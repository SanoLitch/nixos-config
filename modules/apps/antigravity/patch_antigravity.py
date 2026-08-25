#!/usr/bin/env python3
import os
import sys
import shutil
import struct
import stat
import argparse

SEARCH_PATHS = [
    os.path.expanduser("~/.devbox/nix/profile/default/bin/agy"),
    os.path.expanduser("~/.nix-profile/bin/agy"),
    os.path.expanduser("~/.local/bin/agy"),
    "/run/current-system/sw/bin/agy",
    "/usr/local/bin/agy",
    "/usr/bin/agy",
]

def find_binary():
    for path in SEARCH_PATHS:
        if os.path.isfile(path) and os.access(path, os.X_OK):
            return path
    
    agy_path = shutil.which("agy")
    if agy_path:
        return agy_path
        
    return None

def scan_binary_for_pattern(data):
    """
    Fast-scans binary data for the eligibility check gates (Linux x86_64 ELF).
    Returns list of (patch_offset, new_inst_bytes) tuples, or already_patched boolean.
    """
    n = len(data)
    patches = []

    # --- GATE 1: Primary Eligibility Check API Gate ---
    # Finds function that returns "Eligibility check failed: ..."
    target_str = b'Eligibility check failed:'
    str_off = data.find(target_str)

    if str_off != -1:
        pattern = b'\x48\x85\xdb\x0f\x85'  # test rbx, rbx; jne rel32
        idx = 0
        while True:
            idx = data.find(pattern, idx)
            if idx == -1:
                break
            rel32 = struct.unpack('<i', data[idx+5:idx+9])[0]
            jne_target = idx + 9 + rel32
            if 0 <= jne_target < n - 0x200:
                target_chunk = data[jne_target:jne_target+0x200]
                # Check for LEA instruction referencing eligibility string
                for offset in range(0, len(target_chunk) - 7):
                    if target_chunk[offset:offset+3] in (
                        b'\x48\x8d\x05', b'\x48\x8d\x0d', b'\x48\x8d\x15', b'\x48\x8d\x1d',
                        b'\x48\x8d\x25', b'\x48\x8d\x2d', b'\x48\x8d\x35', b'\x48\x8d\x3d'
                    ):
                        disp = struct.unpack('<i', target_chunk[offset+3:offset+7])[0]
                        lea_dest = (jne_target + offset) + 7 + disp
                        if abs(lea_dest - str_off) < 0x100:
                            # Found the eligibility check gate!
                            patch_offset = idx + 3  # Points to 0f 85 ...
                            
                            # Check if already patched
                            if data[patch_offset:patch_offset+1] == b'\xe9' and data[patch_offset+5:patch_offset+6] == b'\x90':
                                break
                                
                            # Calculate relative jump to success block (0x84400f6 / offset 0x220 relative)
                            # Target success epilogue return (idx + 3 + 6 - 0x226 = 0x84400f6)
                            success_rel32 = 0x220
                            new_inst_bytes = b'\xe9' + struct.pack('<i', success_rel32) + b'\x90'
                            patches.append((patch_offset, new_inst_bytes))
                            break
            idx += 1

    # --- GATE 2: TUI Local Input Loop Eligibility Gate ---
    tui_pattern = b'\x41\x80\x3c\x24\x00'  # cmpb $0x0, (%r12)
    idx = 0
    while True:
        idx = data.find(tui_pattern, idx)
        if idx == -1 or idx > n - 25:
            break

        if data[idx+5:idx+7] == b'\x0f\x85':
            rel32 = struct.unpack('<i', data[idx+7:idx+11])[0]
            after_jne = idx + 11

            if rel32 > 0 and data[after_jne] == 0x90 and data[after_jne+1:after_jne+3] == b'\x48\x8d':
                patch_offset = idx + 5
                new_rel32 = rel32 + 1
                new_inst_bytes = b'\xe9' + struct.pack('<i', new_rel32) + b'\x90'
                patches.append((patch_offset, new_inst_bytes))
                break

            if data[after_jne:after_jne+3] in (b'\x48\x8d\x05', b'\x48\x8d\x1d'):
                patch_offset = idx + 5
                new_inst_bytes = b'\x90' * 6
                patches.append((patch_offset, new_inst_bytes))
                break

        idx += 1

    already_patched = len(patches) == 0 and str_off != -1
    return patches, already_patched

def patch_binary(filepath, output_path=None):
    real_path = os.path.realpath(filepath)
    is_read_only = not os.access(real_path, os.W_OK)

    if output_path:
        target_filepath = os.path.abspath(output_path)
    elif is_read_only:
        target_filepath = os.path.abspath("./agy_patched")
        print(f"[*] Read-only source detected: {real_path}")
        print(f"[*] Target output path set to: {target_filepath}")
    else:
        target_filepath = real_path

    if target_filepath != real_path or is_read_only:
        print(f"[*] Copying binary to: {target_filepath}")
        shutil.copy2(real_path, target_filepath)
        st = os.stat(target_filepath)
        os.chmod(target_filepath, st.st_mode | stat.S_IWUSR | stat.S_IXUSR)

    backup_path = target_filepath + ".bak"
    scan_filepath = target_filepath
    if os.path.exists(backup_path):
        print(f"[*] Scanning backup file: {backup_path}")
        scan_filepath = backup_path

    print(f"[*] Reading binary: {scan_filepath}")
    with open(scan_filepath, 'rb') as f:
        data = bytearray(f.read())

    patches, already_patched = scan_binary_for_pattern(data)

    if already_patched:
        print("ℹ️ Binary is already patched.")
        return True

    if not patches:
        print("❌ Error: Eligibility check pattern not found in binary.")
        return False

    # Create backup if in-place patching
    if target_filepath == real_path and not os.path.exists(backup_path):
        print(f"[*] Creating backup: {backup_path}")
        shutil.copy2(target_filepath, backup_path)

    # Apply patches
    with open(target_filepath, 'r+b') as f:
        for offset, new_bytes in patches:
            print(f"[*] Applying patch at offset 0x{offset:x} ({len(new_bytes)} bytes)...")
            f.seek(offset)
            f.write(new_bytes)

    print("✅ Patch applied successfully.")
    print("\n🎉 Run the patched client with:")
    print(f"   AGY_CLI_DISABLE_AUTO_UPDATE=1 {target_filepath}")

    return True

def main():
    parser = argparse.ArgumentParser(description="Antigravity CLI Eligibility Patcher for Linux (x86_64)")
    parser.add_argument("binary", nargs="?", help="Path to agy binary (optional)")
    parser.add_argument("-o", "--output", help="Output path for patched binary")
    args = parser.parse_args()

    target = args.binary or find_binary()

    if not target:
        print("❌ Error: agy binary not found in default paths.")
        print("Please specify the path to your agy binary:")
        print("  python3 patch_antigravity.py /path/to/agy")
        sys.exit(1)

    if not os.path.exists(target):
        print(f"❌ Error: File not found: {target}")
        sys.exit(1)

    success = patch_binary(target, args.output)
    if not success:
        sys.exit(1)

if __name__ == "__main__":
    main()

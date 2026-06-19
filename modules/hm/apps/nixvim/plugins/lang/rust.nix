{ pkgs, ... }:
let
  codelldb_pkg = pkgs.vscode-extensions.vadimcn.vscode-lldb;
  codelldb_path = "${codelldb_pkg}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
  liblldb_path = "${codelldb_pkg}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.so";
in
{
  plugins = {
    rustaceanvim = {
      enable = true;
      settings = {
        dap = {
          adapter = {
            __raw = "require('rustaceanvim.config').get_codelldb_adapter('${codelldb_path}', '${liblldb_path}')";
          };
        };
        server = {
          cmd = [ "${pkgs.rust-analyzer}/bin/rust-analyzer" ];
        };
      };
    };
    crates = {
      enable = true;
      settings = {
        autoLoad = true;
        autoupdate = true;
        smart_insert = true;
      };
    };
  };

  extraPackages = with pkgs; [
    vscode-extensions.vadimcn.vscode-lldb
    rust-analyzer
    clippy
    cargo
    rustc
    rustfmt
  ];
}

# NixOS Configuration

This repository contains my personal NixOS and Home Manager configurations.

## Setup Instructions

### Initial Installation (NixOS)

Follow the standard NixOS installation guide, pointing to this repository as your configuration source.

### Home Manager Initialization

After installing NixOS, ensure Home Manager is properly linked and configured for your user.

## Post-Installation Manual Steps

### Mail (aerc, mbsync)

To set up your email accounts and ensure background synchronization:

1.  **Configure Secrets:**
    *   Create or update the file `config/common/email.json` with your account details.
    *   For Gmail and Yandex, use **App Passwords** instead of your main account password. Ensure App Passwords allow mail access.
    *   Example structure in `config/common/email.json`:
        ```json
        {
          "myaccount": {
            "username": "your_email@example.com",
            "address": "your_email@example.com",
            "password": "your_app_password_for_mail",
            "name": "myaccount",
            "imap": {
              "host": "imap.example.com",
              "port": 993
            }
          }
        }
        ```
        (You can add `password_calendar` field for calendar-specific app passwords if needed).

2.  **Rebuild NixOS/Home Manager:**
    Apply your configuration changes to integrate the new email setup.
    ```bash
    # For NixOS rebuild
    sudo nixos-rebuild switch --flake .#your_hostname
    # For Home Manager only rebuild
    home-manager switch --flake .#your_hostname
    ```

3.  **Manual Synchronization Check:**
    To perform an immediate mail sync and check for errors:
    ```bash
    mbsync -a
    ```
    This will also trigger the notification script.

4.  **Aerc Usage:**
    Launch `aerc` from your terminal to access your mail.

### Calendar (khal, vdirsyncer)

To set up your calendar accounts and ensure background synchronization:

1.  **Configure Secrets:**
    *   Ensure `config/common/email.json` contains `password_calendar` (App Password) for accounts you want to sync calendars for, especially for Yandex.

2.  **Rebuild NixOS/Home Manager:**
    Apply your configuration changes (see step 2 in Mail setup above).

3.  **Discover Calendars:**
    The first time, you need to tell `vdirsyncer` which calendars to sync from your remote accounts.
    ```bash
    vdirsyncer discover
    ```
    Follow the prompts to select the calendar collections you wish to synchronize (usually `y` or `a`).

4.  **Initial Synchronization:**
    After discovery, perform the first full sync:
    ```bash
    vdirsyncer sync
    ```

5.  **Khal Usage:**
    Launch `khal` from your terminal to view your calendars.

## Common Issues & Troubleshooting

*   **`mbsync` or `vdirsyncer` takes too long:** For Gmail, disable IMAP synchronization for the "All Mail" folder in Gmail settings. This is a common cause of slow syncs.
*   **Notifications not arriving:** Ensure `mbsync.service` is running and the `~/.cache/mail_new_count` file is updated. Check `journalctl --user -u mbsync.service`.

---
This README is automatically generated and maintained.

{ ... }:
{
  hydenix.hm.terminals.kitty = {
    enable = true;
    configText = ''
      allow_remote_control yes
      listen_on unix:/tmp/kitty
      shell_integration enabled

      confirm_os_window_close 0

      # kitty-scrollback.nvim Kitten alias
      action_alias kitty_scrollback_nvim kitten /home/sano/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py

      # Browse scrollback buffer in nvim
      map kitty_mod+h kitty_scrollback_nvim
      # Browse output of the last shell command in nvim
      map kitty_mod+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output
      # Show clicked command output in nvim
      mouse_map ctrl+shift+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output

      map ctrl+insert copy_to_clipboard
      map ctrl+k scroll_line_up
      map ctrl+j scroll_line_down
      map ctrl+u scroll_page_up
      map ctrl+d scroll_page_down
      map ctrl+g scroll_home
      # map shift+g scroll_end
      map ctrl+escape kitty_shell window
    '';
  };
}

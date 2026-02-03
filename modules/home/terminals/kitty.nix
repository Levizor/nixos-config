{
  flake.homeModules.kitty = {
    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
      shellIntegration = {
        enableZshIntegration = true;
      };

      settings = {
        dynamic_background_opacity = true;
        disable_ligatures = "cursor";
        cursor_trail = 50;
        scrollback_pager = "bat";
        scrollback_pager_history_size = 10;
        underline_hyperlinks = "always";
        copy_on_select = "clipboard";
        strip_trailing_spaces = "smart";
        focus_follows_mouse = true;
        confirm_os_window_close = 2;
        tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{tab.last_focused_progress_percent}{index}:{title}";
        window_padding_width = 8;

      };

      extraConfig = ''
        map kitty_mod+b launch btop
        map kitty_mod+left neighboring_window left
        map kitty_mod+down neighboring_window bottom
        map kitty_mod+right neighboring_window right
        map kitty_mod+a>0 remote_control set-background-opacity 0
        map kitty_mod+up neighboring_window top

        map ctrl+shift+up scroll_line_up
        map ctrl+shift+down scroll_line_down
        map ctrl+shift+page_up scroll_page_up
        map ctrl+shift+page_down scroll_page_down

        scrollback_lines 2000
        scrollback_pager nvim -c "setlocal nonumber norelativenumber nowrap noshowmode" -c "normal! G" -
        # map kitty_mod+0 show_scrollback
        map kitty_mod+0 launch --type=tab --stdin-source=@screen_scrollback nvim -c "normal! G" -
      '';
    };
  };
}

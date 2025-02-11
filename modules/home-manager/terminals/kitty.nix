{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
    };

    settings = {
      dynamic_background_opacity = true;
      disable_ligutre = "cursor";
      cursor_trail = 50;
      scrollback_pager = "bat";
      scrollback_pager_history_size = 10;
      underline_hyperlinks = "always";
      copy_on_select = "clipboard";
      strip_trailing_spaces = "smart";
      focus_follows_mouse = true;
      confirm_on_window_close = 2;
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{tab.last_focused_progress_percent}{index}:{title}";

    };

    extraConfig = ''
      map kitty_mod+b launch btop
      map ctrl+left neighboring_window left
      map ctrl+down neighboring_window bottom
      map ctrl+right neighboring_window right
      map ctrl+up neighboring_window top
    '';
  };
}

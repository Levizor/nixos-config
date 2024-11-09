{
  programs.wezterm = {
    enable = false;
    enableZshIntegration = true;
    extraConfig = ''
      config.front_end = "WebGpu";
    '';
  };
}

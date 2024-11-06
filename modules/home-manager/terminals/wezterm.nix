{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      config.frontend = "WebGpu";
    '';
  };
}

{}:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    clock24 = true;
    shell = "\${pkgs.zsh}/bin/zsh";
    tmuxp.enable = true;
  };
}

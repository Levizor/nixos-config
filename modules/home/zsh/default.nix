{
  imports = [
    ./zsh.nix
    ./aliases.nix
    # ./binds.nix
    ./oh-my-posh.nix
  ];

  programs.lsd = {
    enable = true;
  };

  programs.dircolors = {
    enable = true;
  };

}

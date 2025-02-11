{
  imports = [
    ./foot.nix
    ./tmux.nix
    # they all consume too much memory :(
    # ./alacritty.nix
    ./wezterm.nix
    #./zellij.nix
    ./kitty.nix
    # ./rio.nix
  ];
}

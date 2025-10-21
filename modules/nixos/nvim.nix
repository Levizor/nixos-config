{ inputs, pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      inputs.nixvim.packages."${system}".default
      vim
    ];

    variables.EDITOR = "nvim";
  };

  programs.nano.enable = false;
}

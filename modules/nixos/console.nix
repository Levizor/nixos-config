{ pkgs, ... }:
{
  console = {
    enable = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];

    font = "FiraCodeNerdFontMono-Regular";
  };
}

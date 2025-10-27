{ pkgs, ... }:
{
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    quickemu
  ];

  virtualisation.libvirtd.enable = true;

}

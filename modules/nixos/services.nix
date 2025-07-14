{ pkgs, ... }:
{
  services = {
    # automounting and virtual filesystems
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;

    tlp.enable = true;
    displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        hide_borders = true;
      };
    };
    displayManager.sddm = {
      enable = false;
      wayland.enable = true;
    };
    upower = {
      enable = true;
    };
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
    xserver = {
      enable = true;
      windowManager = {
        i3 = {
          enable = true;
        };
      };
    };

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    postgresql = {
      enable = true;
      package = pkgs.postgresql;
      ensureDatabases = [ "mydb" ];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database DBuser auth-method
        local all      all    trust
      '';
    };
  };
}

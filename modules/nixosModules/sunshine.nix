{
  flake.nixosModules.sunshine =
    {
      pkgs,
      ...
    }:
    let
      enableVirtualOutput = pkgs.writeShellScript "sunshine-virtual-on" ''
        export NIRI_SOCKET="''${NIRI_SOCKET:-$(ls /run/user/$(id -u)/niri.*.sock 2>/dev/null | head -n1)}"
        ${pkgs.niri}/bin/niri msg output Virtual-1 on || true
        ${pkgs.niri}/bin/niri msg output Virtual-1 custom-mode 1080x1920@60 || true
        ${pkgs.niri}/bin/niri msg output Virtual-1 transform normal || true
        if ${pkgs.niri}/bin/niri msg outputs | grep -q "(HDMI-A-1)"; then
          ${pkgs.niri}/bin/niri msg output Virtual-1 position set -- 3840 -840 || true
        else
          ${pkgs.niri}/bin/niri msg output Virtual-1 position set -- 1920 -840 || true
        fi
      '';
      disableVirtualOutput = pkgs.writeShellScript "sunshine-virtual-off" ''
        export NIRI_SOCKET="''${NIRI_SOCKET:-$(ls /run/user/$(id -u)/niri.*.sock 2>/dev/null | head -n1)}"
        ${pkgs.niri}/bin/niri msg output Virtual-1 off || true
      '';
    in
    {
      boot.kernelModules = [ "vkms" ];

      services.sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;
        settings = {
          sunshine_name = "nixlaptop";
          output_name = "Virtual-1";
          stream_audio = "disabled";
        };
        applications = {
          apps = [
            {
              name = "Desktop";
              image-path = "desktop.png";
              prep-cmd = [
                {
                  do = "${enableVirtualOutput}";
                  undo = "${disableVirtualOutput}";
                }
              ];
            }
          ];
        };
      };
    };
}

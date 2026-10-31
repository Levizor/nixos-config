{
  flake.nixosModules.cage =
    {
      pkgs,
      lib,
      user,
      ...
    }:
    let
      moonlightLab = pkgs.writeShellScriptBin "moonlight-lab" ''
        HOST="nixlaptop"
        APP="Desktop"

        sleep 1

        # Rotate connected output 90 degrees clockwise (transform 90 in wlr-randr)
        for out in $(${pkgs.wlr-randr}/bin/wlr-randr --json | ${pkgs.jq}/bin/jq -r '.[].name'); do
          ${pkgs.wlr-randr}/bin/wlr-randr --output "$out" --mode 1920x1080@60Hz --transform 90 || \
          ${pkgs.wlr-randr}/bin/wlr-randr --output "$out" --preferred --transform 90 || true
        done

        while true; do
          if ${pkgs.netcat}/bin/nc -z -w 2 "$HOST" 47989 >/dev/null 2>&1; then
            echo "[moonlight-lab] Connecting to $HOST ($APP)..."
            SDL_AUDIODRIVER=dummy ${pkgs.moonlight-qt}/bin/moonlight stream "$HOST" "$APP" \
              --resolution 1080x1920 \
              --fps 60 \
              --display-mode fullscreen \
              --audio-on-host \
              --quit-after 2>&1 | while IFS= read -r line; do
                echo "$line"
                case "$line" in
                  *"Cleaning up platform"*|*"Host returned error"*|*"Request failed"*|*"is now offline"*|*"ConnectionRefusedError"*)
                    ${pkgs.procps}/bin/pkill -f "moonlight stream" || true
                    break
                    ;;
                esac
              done
          fi
          sleep 2
        done
      '';

      moonlightPair = pkgs.writeShellScriptBin "moonlight-pair-laptop" ''
        PIN="''${1:-1234}"
        echo "Pairing with nixlaptop using PIN $PIN..."
        echo "Enter this PIN in Sunshine Web UI (https://localhost:47990) on nixlaptop."
        QT_QPA_PLATFORM=offscreen ${pkgs.moonlight-qt}/bin/moonlight pair nixlaptop --pin "$PIN"
      '';
    in
    {
      hardware.graphics.enable = true;

      services.cage = {
        enable = true;
        restartIfChanged = true;
        user = user;
        program = lib.getExe moonlightLab;
        extraArguments = [
          "-s"
        ];
      };

      systemd.services."getty@tty1".enable = false;
      systemd.services."autovt@tty1".enable = false;

      systemd.services."cage-tty1" = {
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Restart = "always";
          RestartSec = "2s";
          TimeoutStopSec = "5s";
        };
      };

      environment.systemPackages = [
        pkgs.moonlight-qt
        moonlightLab
        moonlightPair
      ];
    };
}

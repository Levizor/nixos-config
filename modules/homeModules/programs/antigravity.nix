{
  flake.homeModules.antigravity =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      home.packages = with pkgs; [
        antigravity-ide
      ];

      programs.antigravity-cli.enable = true;

      systemd.user.services.antigravity-cli-daemon = {
        Unit = {
          Description = "antigravity remote-control daemon";
          After = [ "network.target" ];
          StartLimitIntervalSec = 0;
        };

        Service = {
          Type = "simple";
          ExecStart = "${lib.getExe pkgs.antigravity-cli} remote-control serve";
          WorkingDirectory = "${config.home.homeDirectory}/Projects";
          Restart = "on-failure";
          RestartSec = "10s";
          RestartPreventExitStatus = 3;
          TimeoutStopSec = "30s";
          StandardOutput = "journal";
          StandardError = "journal";
        };

        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };
}

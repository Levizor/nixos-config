{ inputs, ... }:
{
  flake.nixosModules.openclaw =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      openclawPkg = inputs.nix-openclaw.packages.${pkgs.stdenv.hostPlatform.system}.default;
    in
    {
      imports = [
        inputs.nix-openclaw.nixosModules.openclaw-gateway
      ];

      # Secrets for Telegram bot and Gemini API
      sops.secrets."telegram_claw_bot" = {
        owner = config.user;
      };
      sops.secrets."gemini_api_key" = {
        owner = config.user;
      };

      # Render secrets into environment variables for OpenClaw daemon
      sops.templates."openclaw-env" = {
        owner = config.user;
        content = ''
          TELEGRAM_BOT_TOKEN="${config.sops.placeholder."telegram_claw_bot"}"
          GEMINI_API_KEY="${config.sops.placeholder."gemini_api_key"}"
        '';
      };

      services.openclaw-gateway = {
        enable = true;
        user = config.user;
        group = "users";
        createUser = false;
        stateDir = "/home/${config.user}/.local/share/openclaw";
        package = openclawPkg;

        environmentFiles = [
          config.sops.templates."openclaw-env".path
        ];

        environment = {
          OPENCLAW_NIX_MODE = "1";
          OPENCLAW_BUNDLED_PLUGINS_DIR = "${openclawPkg}/lib/node_modules/openclaw/dist/extensions";
        };

        servicePath = with pkgs; [
          git
          bash
          coreutils
          ripgrep
          fd
          nix
        ];

        config = {
          gateway = {
            mode = "local";
          };
          models = {
            providers = {
              google = {
                api = "google-generative-ai";
              };
            };
          };
          agents = {
            defaults = {
              workspace = "/home/${config.user}/Projects";
              model = {
                primary = "google/gemini-3.8-flash";
                fallbacks = [
                  "google/gemini-2.5-pro"
                  "google/gemini-2.5-flash"
                ];
              };
            };
          };
          tools = {
            exec = {
              mode = "ask";
            };
          };
          channels = {
            telegram = {
              enabled = true;
              dmPolicy = "pairing";
              richMessages = true;
            };
          };
        };
      };

      # Make openclaw CLI available for pairing approvals and status
      environment.systemPackages = [
        openclawPkg
      ];

      environment.variables = {
        OPENCLAW_NIX_MODE = "1";
        OPENCLAW_STATE_DIR = "/home/${config.user}/.local/share/openclaw";
        OPENCLAW_CONFIG_PATH = "/etc/openclaw/openclaw.json";
        OPENCLAW_BUNDLED_PLUGINS_DIR = "${openclawPkg}/lib/node_modules/openclaw/dist/extensions";
      };
    };
}

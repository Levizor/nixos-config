{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  programs.zen-browser = {
    enable = true;

    profiles = {
      profile_0 = {
        id = 0;
        isDefault = true;
        name = "profile_0";

        search = {
          force = true;
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "NixOS Wiki" = {
              urls = [ { template = "https://wiki.nixos.org/index.php?search={searchTerms}"; } ];
              icon = "https://wiki.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };

            "NixVim" = {
              urls = [
                {
                  template = "https://nix-community.github.io/nixvim/search/?option_scope=0&option=plugins.nvim-surround.settings&query={searchTerms}";
                }
              ];
              icon = "https://wiki.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nv" ];

            };
            "Brave" = {
              urls = [ { template = "https://search.brave.com/search?q={searchTerms}"; } ];
              icon = "https://brave.com/static-assets/images/brave-logo-sans-text.svg";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@b" ];
            };
          };

          default = "Brave";
          privateDefault = "Brave";
        };
        settings = {
          "zen.keyboard.shortcuts.version" = 9;
          "zen.sidebar-expanded" = false;
          "zen.mods.updated-value-observer" = true;
          "zen.sidebar.enabled" = false;
          "zen.tabs.show-newtab-vertical" = false;
          "zen.theme.accent-color" = "#d4bbff";
          "zen.theme.color-prefs.colorful" = true;
          "zen.ui.migration.version" = 2;
          "zen.urlbar.behavior" = "float";
          "zen.view.compact.hide-toolbar" = true;
          "zen.view.compact.should-enable-at-startup" = true;
          "zen.view.compact.toolbar-flash-popup" = true;
          "zen.view.sidebar-expanded" = false;
          "zen.view.split-view.change-on-hover" = true;
          "zen.view.use-single-toolbar" = false;
          "zen.welcome-screen.seen" = true;
          "zen.welcomeScreen.seen" = true;
          "zen.workspaces.continue-where-left-off" = true;
          "zen.workspaces.hide-default-container-indicator" = false;
          "zen.workspaces.separate-essentials" = false;

        };
      };
    };

    policies = {

      Preferences = {
        "app.normandy.first_run" = false;
        "app.update.auto" = false;
        "app.update.disable_button.showUpdateHistory" = false;
        "browser.download.lastDir" = "${config.home.homeDirectory}/Downloads";
        "browser.newtabpage.enabled" = false;
        "extensions.ui.dictionary.hidden" = true;
        "extensions.ui.extension.hidden" = false;
        "extensions.ui.lastCategory" = "addons://list/extension";
        "extensions.ui.locale.hidden" = true;
        "extensions.ui.mlmodel.hidden" = true;
        "extensions.ui.sitepermission.hidden" = true;
        "extensions.webextensions.ExtensionStorageIDB.migrated.keepassxc-browser@keepassxc.org" = true;
        "extensions.webextensions.ExtensionStorageIDB.migrated.screenshots@mozilla.org" = true;
        "extensions.webextensions.ExtensionStorageIDB.migrated.sponsorBlocker@ajay.app" = true;
        "extensions.webextensions.ExtensionStorageIDB.migrated.uBlock0@raymondhill.net" = true;
        "extensions.webextensions.ExtensionStorageIDB.migrated.vimium-c@gdh1995.cn" = true;
      };

      DisableTelemetry = true;
      DisplayBookmarksToolbar = "never";
      DisablePocket = true;
      DisableFirefoxAccounts = true;

      ExtensionSettings = {
        "deArrow@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/dearrow/latest.xpi";
          installation_mode = "normal_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "normal_installed";
        };

        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "normal_installed";
        };

        "vimium-c@gdh1995.cn" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
          installation_mode = "normal_installed";
        };

        "keepassxc-browser@keepassxc.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "normal_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "normal_installed";
        };
        "queryamoid@kaply.com" = {
          install_url = "https://github.com/mkaply/queryamoid/releases/download/v0.2/query_amo_addon_id-0.2-fx.xpi";
          installation_mode = "normal_installed";
        };
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "normal_installed";
        };
      };
    };
  };
  home.file.".zen/profile_0" = {
    source = ./zen-themes.json;
  };
}

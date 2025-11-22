{ pkgs, inputs, ... }:
let
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
        "floorp.browser.sidebar.enable" = false;
        "floorp.lepton.interface" = 1;
        "userChrome.autohide.navbar" = true;
        "browser.uiCustomization.state" =
          "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"vimium-c_gdh1995_cn-browser-action\",\"keepassxc-browser_keepassxc_org-browser-action\",\"queryamoid_kaply_com-browser-action\"],\"nav-bar\":[\"undo-closed-tab\",\"back-button\",\"forward-button\",\"sidebar-reverse-position-toolbar\",\"sidebar-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"save-to-pocket-button\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\",\"sponsorblocker_ajay_app-browser-action\",\"profile-manager\",\"jid1-mnnxcxisbpnsxq_jetpack-browser-action\",\"ublock0_raymondhill_net-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"],\"statusBar\":[\"screenshot-button\",\"fullscreen-button\",\"status-text\"]},\"seen\":[\"developer-button\",\"sponsorblocker_ajay_app-browser-action\",\"vimium-c_gdh1995_cn-browser-action\",\"sidebar-reverse-position-toolbar\",\"undo-closed-tab\",\"profile-manager\",\"jid1-mnnxcxisbpnsxq_jetpack-browser-action\",\"keepassxc-browser_keepassxc_org-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"queryamoid_kaply_com-browser-action\",\"workspaces-toolbar-button\"],\"dirtyAreaCache\":[\"nav-bar\",\"statusBar\",\"unified-extensions-area\",\"TabsToolbar\",\"PersonalToolbar\",\"toolbar-menubar\"],\"currentVersion\":20,\"newElementCount\":2}";
        "userChrome.centered.tab" = true;
        "userChrome.centered.urlbar" = true;
        "userChrome.urlView.always_show_page_actions" = true;
        "floorp.tabsleep.enabled" = true;
        "floorp.tabsleep.tabTimeoutMinutes" = 20;
        "toolkit.tabbox.switchByScrolling" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "signon.rememberSignons" = false;
      };
    };
  };

  policies = {
    DefaultDownloadDirectory = "\${home}/downloads";
    DisableTelemetry = true;
    DisplayBookmarksToolbar = "never";
    DisplayMenuBar = "default-off";
    DisablePocket = true;
    DisableFirefoxAccounts = true;
    DisableSetDesktopBackground = true;
    SearchBar = "unified";

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
in
{
  stylix.targets.floorp.profileNames = [ "profile_0" ];
  stylix.targets.firefox.profileNames = [ "profile_0" ];
  programs.floorp = {
    enable = false;
    policies = policies;
    profiles = profiles;
  };
  programs.firefox = {
    enable = false;
    policies = policies;
    profiles = profiles;
  };
}

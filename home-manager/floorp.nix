{pkgs, ...}:
{
  programs.floorp = {
    enable = true;
    languagePacks = [
      "en-US"
      "uk"
    ];

    # profiles = { 
    #   profile_0 = {
    #     id = 1;
    #     isDefault = true;
    #     name = "Levizor";
    #     
    #     search = {
    #       engines = {
    #         "Nix Packages" = {
    #           urls = [{
    #             template = "https://search.nixos.org/packages";
    #             params = [
    #               { name = "type"; value = "packages"; }
    #               { name = "query"; value = "{searchTerms}"; }
    #             ];
    #           }];
    #
    #           icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    #           definedAliases = [ "@np" ];
    #         };
    #
    #         "NixOS Wiki" = {
    #           urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}"; }];
    #           iconUpdateURL = "https://wiki.nixos.org/favicon.png";
    #           updateInterval = 24 * 60 * 60 * 1000; # every day
    #           definedAliases = [ "@nw" ];
    #         };
    #
    #         "Bing".metaData.hidden = true;
    #         "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
    #
    #         "Brave" = {
    #           urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
    #           iconUpdateURL = "https://brave.com/static-assets/images/brave-logo-sans-text.svg";
    #           updateInterval = 24 * 60 * 60 * 1000; # every day
    #           definedAliases = ["@b"];
    #         };
    #       };
    #
    #       default = "Brave";
    #       privateDefault = "Brave";
    #     };
    #   };
    # };

    policies = {
      defaultdownloaddirectory = "\${home}/downloads";
      disabletelemetry = true;
      displaybookmarkstoolbar = "never";
      displaymenubar = "default-off";
      disablepocket = true;
      disablefirefoxaccounts = true;
      disablesetdesktopbackground = true;
      searchbar = "unified";

      extensionsettings = {
        # "*" = {
        #   installation_mode = "normal_installed"; 
        # };
        "ublock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "normal_installed"; 
        };

        # privacy badger:
        "jid1-mnnxcxisbpnsxq@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
        };

        "vimium-c@gdh1995.cn" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
          installation_mode = "force_installed";
        };

        "keepassxc-browser@keepassxc.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
        };
      };
    };
  };
}

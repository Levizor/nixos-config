{
  flake.homeModules.xdg = {
    xdg = {
      mimeApps = {
        enable = true;
        defaultApplications = {
          "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
          "x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];
          "image/png" = [ "org.gnome.Loupe.desktop" ];
          "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
          "image/gif" = [ "org.gnome.Loupe.desktop" ];
          "image/webp" = [ "org.gnome.Loupe.desktop" ];
          "text/*" = [ "nvim.desktop" ];
          "text/plain" = [ "nvim.desktop" ];
          "text/x-log" = [ "nvim.desktop" ];
          "text/markdown" = [ "nvim.desktop" ];
          "x-scheme-handler/http" = [ "zen-twilight.desktop" ];
          "x-scheme-handler/https" = [ "zen-twilight.desktop" ];
          "x-scheme-handler/chrome" = [ "zen-twilight.desktop" ];
          "text/html" = [ "zen-twilight.desktop" ];
          "application/x-extension-htm" = [ "zen-twilight.desktop" ];
          "application/x-extension-html" = [ "zen-twilight.desktop" ];
          "application/x-extension-shtml" = [ "zen-twilight.desktop" ];
          "application/xhtml+xml" = [ "zen-twilight.desktop" ];
          "application/x-extension-xhtml" = [ "zen-twilight.desktop" ];
          "application/x-extension-xht" = [ "zen-twilight.desktop" ];
        };
      };
    };
    xdg.configFile."mimeapps.list".force = true;
  };
}

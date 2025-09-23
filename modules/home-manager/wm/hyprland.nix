{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  monitors = [
    {
      name = "eDP-1";
      config = "1920x1080@60, 0x0, 1,";
    }
    {
      name = "HDMI-A-1";
      config = "preferred, auto, 1,";
    }
  ];
  monitorNames = map (m: m.name) monitors;

  scriptDefs = import ./scripts.nix {
    inherit pkgs lib monitors;
  };

  monitorToggleScript = lib.getExe scriptDefs.monitorToggleScript;
  tmuxInitScript = lib.getExe scriptDefs.tmuxInitScript;
  animationsToggleScript = lib.getExe scriptDefs.animationsToggleScript;
  decorationsToggleScript = lib.getExe scriptDefs.decorationsToggleScript;
  gapsToggleScript = lib.getExe scriptDefs.gapsToggleScript;
  forceKillScript = lib.getExe scriptDefs.forceKillScript;
  openOnFocusScript = lib.getExe scriptDefs.openOnFocusScript;
in
{
  services.hyprpaper.enable = lib.mkForce false;
  wayland.windowManager.hyprland = {
    enable = true;

    package = null;
    portalPackage = null;
    systemd = {
      variables = [ "--all" ];
      enableXdgAutostart = true;
    };
    xwayland.enable = true;

    settings = {
      monitor = map (m: "${m.name}, ${m.config}") monitors;
      "$mod" = "SUPER";

      "$browser" = "zen";
      "$terminal" = "kitty -1";
      "$telegram" = "${lib.getExe pkgs.telegram-desktop}";
      "$fileManager" = "${lib.getExe pkgs.nemo}";
      "$menu" = "${lib.getExe pkgs.fuzzel}";
      "$player" = "${lib.getExe pkgs.youtube-music}";
      "source" = "~/.config/hypr/impure.conf";

      env = [
        "TERMINAL, kitty -1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "GTK_USE_PORTAL=1"
        "XCURSOR_SIZE, 30"
        "NIXOS_OZONE_WL, 1"
      ];

      input = {
        kb_layout = "us,ua,ru,pl";
        kb_options = "grp:alt_space_toggle";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          tap-to-click = true;
        };

        sensitivity = 0;
        repeat_delay = 250;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        initial_workspace_tracking = false;
        enable_anr_dialog = false;
      };

      general = {
        gaps_in = 5;
        gaps_out = 15;
        border_size = 3;

        layout = "dwindle";
      };

      decoration = {
        rounding = 5;

        blur = {
          enabled = false;
          size = 3;
          passes = 3;
        };
      };

      animations = {
        enabled = false;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier, slidevert"
          "windowsOut, 1, 7, default, slidevert"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default, slidevert"
          "specialWorkspace, 1, 7, default, slide"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
      };

      exec-once = [
        # ensures screensharing
        "touch ~/.config/hypr/impure.conf"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP GTK_USE_PORTAL"
        "hyprctl dispatch workspace 2"
        "${tmuxInitScript}"
        # "${openOnFocusScript}"
        "clipse -listen"
        "wpaperd"
      ];

      bind =
        let
          screenshotDir = "${config.home.homeDirectory}/Pictures/Screenshots";
        in
        [
          # Utils
          "$mod, Q, killactive,"
          "$mod, V, togglefloating,"
          "$mod, P, pseudo, # dwindle"
          "$mod, F, fullscreen"

          # Terminal launches
          "$mod, Return, exec, $terminal"
          "$mod SHIFT, Return, exec, $terminal -o # background_opacity=0.4"
          "$mod, A, exec, $terminal --app-id btop ncpamixer"
          "$mod, U, exec, $terminal --app-id btop  btop"
          "$mod_Alt, p, exec, $terminal nvim ~/nix/modules/home-manager/packages.nix"

          # Other application launches
          "$mod, T, exec, $telegram"
          "$mod, E, exec, $fileManager --class files"
          "CTRL_$mod, W, exec, $browser"
          "$mod, W, exec, pgrep -x '.*$browser.*' > /dev/null || $browser"
          "$mod, D, exec, $menu"
          "$mod, C, exec, $terminal --app-id 'clipse' 'clipse'"
          "CTRL_$mod, P, exec, $player"
          ", F10, exec, wl-copy $(hyprpicker)"
          "$mod, Escape, exec, wlogout"

          # Switch wallpapers
          "$mod, F6, exec, wpaperctl next-wallpaper"
          "$mod, F4, exec, wpaperctl previous-wallpaper"

          # Screenshots
          ", Print , exec, grimblast copy area"
          "$mod, Print, exec, grimblast copysave active \"${screenshotDir}/screenshot_$(date +\"%Y%m%d_%H%M%S\").png\""

          # Scripts
          "$mod Shift, Q, exec, ${forceKillScript}"
          "$mod, F1, exec, ${decorationsToggleScript}"
          "$mod, F2, exec, ${animationsToggleScript}"
          "$mod, F3, exec, ${gapsToggleScript}"

          "$mod, F7, exec, ${monitorToggleScript} 0"
          "$mod, F8, exec, ${monitorToggleScript} 1"
          "$mod, F9, exec, ${monitorToggleScript} 2"

          # switch to specific language
          # english
          "bind = $mod_Shift, E, exec, hyprctl switchxkblayout all 0"
          # ukrainian
          "bind = $mod_Shift, U, exec, hyprctl switchxkblayout all 1"
          # russian
          "bind = $mod_Shift, R, exec, hyprctl switchxkblayout all 2"
          # polish
          "bind = $mod_Shift, P, exec, hyprctl switchxkblayout all 3"

          # Volume
          ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +10%"
          "$mod, KP_Up,  exec, pactl set-sink-volume @DEFAULT_SINK@ +10%"
          ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -10%"
          "$mod, KP_Down,  exec, pactl set-sink-volume @DEFAULT_SINK@ -10%"
          ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
          "$mod, KP_Begin, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"

          # Brightness
          ",XF86MonBrightnessUp , exec, brightnessctl set +10%"
          ",XF86MonBrightnessDown , exec, brightnessctl set 10%-"

          # Move focus with mod + arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          # special workspaces
          "$mod, S, togglespecialworkspace, terminal"
          "$mod SHIFT, S, movetoworkspace, special:terminal"
          # "$mod, T, togglespecialworkspace, telegram"
          # "$mod SHIFT, T, movetoworkspace, special:telegram"

          #Move active window in directions
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"
          "$mod SHIFT, l, movewindow, r"
          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, k, movewindow, u"
          "$mod SHIFT, j, movewindow, d"

          "$mod, W, workspace, 6"
          "$mod Alt, W, focusworkspaceoncurrentmonitor, 6 "
          "$mod, T, workspace, 1"
          "$mod, T, focusworkspaceoncurrentmonitor, 1"
          "$mod, 0, workspace, 10"
          "$mod SHIFT, 0, movetoworkspace, 10"
          "$mod Alt, 0, focusworkspaceoncurrentmonitor, 10 "
        ]
        ++ (
          #binds for workspaces
          builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = toString (i + 1);
              in
              [
                "$mod, ${ws}, workspace, ${ws}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${ws}"
                "$mod Alt, ${ws}, focusworkspaceoncurrentmonitor, ${ws} "
              ]
            ) 9
          )
        );

      bindm = [
        # Move/resize windows with mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # gesture = [
      #   "3, swipe, workspace"
      #   "3, pinch, fullscreen "
      # ];

      workspace =
        let
          totalWorkspaces = 10;

          mod = a: b: a - (a / b) * b;

          numMonitors = builtins.length monitorNames;
          basePerMonitor = totalWorkspaces / numMonitors;
          extra = mod totalWorkspaces numMonitors;
          # Assign workspace numbers to monitor indices
          workspaceAssignments = builtins.concatLists (
            builtins.genList (
              i:
              let
                count = basePerMonitor + (if i < extra then 1 else 0);
              in
              builtins.genList (_: i) count
            ) numMonitors
          );
        in
        [
          "w[tv1], gapsout:0, gapsin:0"
          "f[1], gapsout:0, gapsin:0"
          "special:telegram, decorate:false, border:false, on-created-empty:$telegram, gapsin:0, gapsout:0"
          "special:terminal, border:false, on-created-empty:$terminal tmuxp load --yes dev, gapsin:0, gapsout:0"
        ]
        ++ (builtins.genList (
          i:
          let
            ws = toString (i + 1);
            monitorIndex = builtins.elemAt workspaceAssignments i;
            monitor = builtins.elemAt monitorNames monitorIndex;
          in
          "${ws}, monitor:${monitor}"
        ) totalWorkspaces);

      windowrulev2 = [
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
        "suppressevent maximize, class:.* # You'll probably like this."

        "workspace special:telegram, class:(org.telegram.desktop.*)"

        "size 95% 95%, class:(btop)"
        "float, class:(btop)"

        "float, class:(files)"
        "size 60% 60%, centered, title:(.*Files)$"

        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"

        "float, class:(clipse)"
        "size 622 652, class:(clipse)"

        # Telegram
        "workspace 1, class: ^(?i).*(telegram).*"

        # KeePassXC
        "workspace 2, class:^(?i).*(keepassxc).*"

        # Music
        "workspace 3, class:^(?i).*(youtube_music|ytmdesktop).*"

        # Vesktop /
        "workspace 4, class:^(vesktop)$"

        # Teams
        "workspace 5, class:^(teams-for-linux)$"

        # Browser (WS6)
        "workspace 6, class:^(?i).*(firefox|chromium|brave|floorp|zen).*"

        # Steam + Games
        "workspace 8, class:^(steam)$"
        "workspace 9, title:^(.*)$, class:^(steam_app_.*)$"

        # MPV
        "workspace 10, class:^(mpv)$"
      ];

    };

    extraConfig = ''
      # Resize submap
          bind=$mod,R,submap,resize
          submap=resize
          binde=,right,resizeactive,0 0
          binde=,left,resizeactive,-10 0
          binde=,up,resizeactive,0 -10
          binde=,down,resizeactive,0 10
          binde=,l,resizeactive,30 0
          binde=,h,resizeactive,-30 0
          binde=,k,resizeactive,0 -30
          binde=,j,resizeactive,0 30
          bind=,Escape,submap,reset
          bind=,Return,submap, reset
          bind=$mod,r,submap, reset
          submap=reset

    '';
  };
}

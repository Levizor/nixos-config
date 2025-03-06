{
  pkgs,
  lib,
  ...
}:
let
  scripts = ./scripts;
  monitors = [
    "eDP-1"
    "HDMI-A-1"
  ];
in
{
  services.hyprpaper.enable = lib.mkForce false;
  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      variables = [ "--all" ];
      enableXdgAutostart = true;
    };
    xwayland.enable = true;

    settings = {
      monitor = [
        "${builtins.elemAt monitors 0}, 1920x1080@60, 0x0, 1,"
        "${builtins.elemAt monitors 1}, preferred, auto, 1,# mirror, eDP-1"
      ];

      "$mod" = "SUPER";

      "$browser" = "floorp";
      "$terminal" = "kitty -1";
      "$telegram" = "telegram-desktop";
      "$fileManager" = "nemo";
      "$menu" = "fuzzel";
      "$player" = "youtube-music";

      env = [
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XCURSOR_SIZE, 30"
        "QT_STYLE_OVERRIDE=kvantum"
      ];

      input = {
        kb_layout = "us,ua,ru";
        # kb_variant = ", ua";
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

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        initial_workspace_tracking = false;
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

      exec-once =
        let

          tmuxUpdateScript = pkgs.writeShellScriptBin "tmuxUpdateScript" ''
            while true;
            do
              pgrep tmux &>/dev/null || break
              tmux refresh-client -S;
              sleep 0.1;
            done &
          '';
        in
        [
          # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "${lib.getExe tmuxUpdateScript}"
          "clipse -listen"
          "wpaperd"
        ];

      bind =
        let
          screenshotDir = "${builtins.getEnv "HOME"}/Pictures/Screenshots";
          home.file."Pictures/Screenshots/".exists = true;
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
          "$mod, D, exec, $menu"
          "$mod, C, exec, $terminal --app-id 'clipse' 'clipse'"
          "CTRL_$mod, P, exec, $player"
          ", F10, exec, wl-copy $(hyprpicker)"
          "$mod, pause, exec, wlogout"

          # Switch wallpapers
          "$mod, F6, exec, wpaperctl next-wallpaper"
          "$mod, F4, exec, wpaperctl previous-wallpaper"

          # Screenshots
          ", Print , exec, grimblast copy area"
          "$mod, Print, exec, grimblast copysave active \"${screenshotDir}/screenshot_$(date +\"%Y%m%d_%H%M%S\").png\""

          # Scripts
          "$mod Shift, Q, exec, ${scripts}/forcekill.sh"
          "$mod, F1, exec, ${scripts}/decorations.sh"
          "$mod, F2, exec, ${scripts}/animations.sh"
          "$mod, F3, exec, ${scripts}/gapsoff.sh"

          # switch to specific language
          # english
          "bind = $mod_Shift, E, exec, hyprctl switchxkblayout all 0"
          # ukrainian
          "bind = $mod_Shift, U, exec, hyprctl switchxkblayout all 1"
          # russian
          "bind = $mod_Shift, R, exec, hyprctl switchxkblayout all 2"

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

          # Example special workspace (scratchpad)
          "$mod, S, togglespecialworkspace, terminal"
          "$mod SHIFT, S, movetoworkspace, special:terminal"
          "$mod, T, togglespecialworkspace, telegram"
          "$mod SHIFT, T, movetoworkspace, special:telegram"
          "$mod, W, togglespecialworkspace, browser"
          "$mod SHIFT, W, movetoworkspace, special:browser"

          #Move active window in directions
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"
          "$mod SHIFT, l, movewindow, r"
          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, k, movewindow, u"
          "$mod SHIFT, j, movewindow, d"

        ]
        ++ (
          #binds for workspaces
          builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "$mod, ${toString ws}, workspace, ${toString ws}"
                "$mod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
                "$mod Alt, ${toString ws}, focusworkspaceoncurrentmonitor, ${toString ws} "
              ]
            ) 9
          )
        );

      bindm = [
        # Move/resize windows with mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      workspace =
        [
          "w[tv1], gapsout:0, gapsin:0"
          "f[1], gapsout:0, gapsin:0"
          "special:telegram, decorate:false, border:false, on-created-empty:$telegram, gapsin:0, gapsout:0"
          "special:terminal, border:false, on-created-empty:$terminal tmuxp load scratchpad, gapsin:0, gapsout:0"
          "special:browser, on-created-empty:$browser, gapsin:0, gapsout:0"
        ]
        ++ (
          # connect workspaces to monitors
          builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "${
                  if ws <= 5 then
                    "${toString ws}, monitor:${builtins.elemAt monitors 0}"
                  else
                    "${toString ws}, monitor ${builtins.elemAt monitors 1}"
                }"
              ]
            ) 9
          )
        );

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

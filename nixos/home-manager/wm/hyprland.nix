{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true; 

    extraConfig = 
        ''
          $scripts = ~/nix/home-manager/wm/scripts

          $browser = librewolf
          $terminal = kitty
          $telegram = telegram-desktop
          $fileManager = thunar
          $menu = fuzzel

          ####################
          ### KEYBINDINGSS ###
          ####################

          $mainMod = SUPER

      #makes waybar with workspaces visible when pressing key
      # bindt = , Alt_L, exec, pkill -o -SIGUSR1 waybar
      # bindrt = $mainMod, Alt_L, exec, pkill -o -SIGUSR1 waybar
          bind = $mainMod, Tab, exec, killall -SIGUSR1 waybar

          bind = $mainMod, KP_END, exec, killall waybar || waybar

      # bind = SUPER, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy

          binde = SUPER, H, exec, echo key kp4| dotoolc
          binde = SUPER, J, exec, echo key kp2| dotoolc
          binde = SUPER, K, exec, echo key kp8| dotoolc
          binde = SUPER, L, exec, echo key kp6| dotoolc
          binde = SUPER, U, exec, echo key kp9| dotoolc
          binde = SUPER, D, exec, echo key kp3| dotoolc
          binde = Ctrl, K, exec, echo key kp9| dotoolc
          binde = Ctrl, J, exec, echo key kp3| dotoolc
          bind = $mainMod, KP_Subtract, exec, wpaperctl next
          bind = $mainMod, KP_Add, exec, killall wpaperd | ls ~/.config/wpaperd/config.toml | entr -r wpaperd

          bind = $mainMod, Return, exec, $terminal 
          bind = $mainMod SHIFT, Return, exec, $terminal -o background_opacity=0.4
          bind = $mainMod, U, exec, $terminal --class btop -e btop 
          bind = $mainMod, KP_Prior, exec, $terminal -e nvim ~/.config/hypr/binds.conf
          bind = $mainMod, KP_HOME, exec, $terminal -e nvim ~/.config/hypr/hyprland.conf
          bind = $mainMod, Q, killactive, 
          bind = $mainMod Shift, Q, exec, $scripts/forcekill.sh
          bind = $mainMod, KP_Insert, exec, $scripts/fixScreenshare.sh
          bind = $mainMod, E, exec, $fileManager --class files
          bind = CTRL_$mainMod, W, exec, $browser
          bind = $mainMod, C, exec, $terminal --class 'clipse' -e 'clipse'
          bind = CTRL_$mainMod, P, exec, $player
          bind = $mainMod, T, exec, $telegram
          bind = $mainMod, V, togglefloating, 
          bind = $mainMod, D, exec, $menu
          bind = $mainMod, P, pseudo, # dwindle
          bind = $mainMod, B, togglesplit, # dwindle
          bind = $mainMod, F, fullscreen
          bind =  , Print , exec, grimblast copy area
          bind = $mainMod, Print, exec, grimblast copy output screen
          bind = , scroll_lock , exec, pkill -n -SIGUSR1 waybar
          bind = , F10, exec, wl-copy $(hyprpicker)
          
          bind = $mainMod, N, swapactiveworkspaces, eDP-1 HDMI-A-1
          bind = $mainMod, C, centerwindow

      #groups
          bind = $mainMod, W, togglegroup

      #Volume and backlight
          bind = ,XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +10%
          bind = $mainMod, KP_Up,  exec, pactl set-sink-volume @DEFAULT_SINK@ +10%
          bind = ,XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -10%
          bind = $mainMod, KP_Down,  exec, pactl set-sink-volume @DEFAULT_SINK@ -10%
          bind = , XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
          bind = $mainMod, KP_Begin, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle

          bind = ,XF86MonBrightnessUp , exec, brightnessctl set +10%
          bind = ,XF86MonBrightnessDown , exec, brightnessctl set 10%-

      #Notifitations
      #bind = 

          bind = , F12, exec, nmcli device wifi

      # Move focus with mainMod + arrow keys
          bind = $mainMod, left, movefocus, l
          bind = $mainMod, right, movefocus, r
          bind = $mainMod, up, movefocus, u
          bind = $mainMod, down, movefocus, d

          bind = $mainMod, h, movefocus, l
          bind = $mainMod, l, movefocus, r
          bind = $mainMod, k, movefocus, u
          bind = $mainMod, j, movefocus, d

          bind = $mainMod, grave, submap, Keys
          submap = Keys
          bind = $mainMod, grave, submap, reset
          submap = reset 

      # will switch to a submap called resize
          bind=ALT,R,submap,resize

      # will start a submap called "resize"
          submap=resize

      # sets repeatable binds for resizing the active window
          binde=,right,resizeactive,0 0
          binde=,left,resizeactive,-10 0
          binde=,up,resizeactive,0 -10
          binde=,down,resizeactive,0 10
          binde=,l,resizeactive,30 0
          binde=,h,resizeactive,-30 0
          binde=,k,resizeactive,0 -30
          binde=,j,resizeactive,0 30
          bind=,escape,submap,reset 
          bind=,Return,submap, reset
          bind=$mainMod,r,submap, reset

          submap=reset


          bind=$mainMod, pause, exec, wlogout
          submap=System


          bind = shift, s, exec, systemctl poweroff -i
          bind = , r, exec, systemctl reboot
          bind = , h, exec, systemctl hibernate
          bind = , e, exit
          bind = , l, exec, hyprctl dispatch submap reset & hyprlock

          bind = , escape, submap, reset

          submap=reset

      # keybinds further down will be global again...
      #bind = $mainMod, Tab,cyclenext,          # change focus to another window
      #bind = $mainMod, Tab,bringactivetotop,   # bring it to the top

      # Switch workspaces with mainMod + [0-9]
          bind = $mainMod, 1, workspace, 1
          bind = $mainMod, 2, workspace, 2
          bind = $mainMod, 3, workspace, 3
          bind = $mainMod, 4, workspace, 4
          bind = $mainMod, 5, workspace, 5
          bind = $mainMod, 6, workspace, 6
          bind = $mainMod, 7, workspace, 7
          bind = $mainMod, 8, workspace, 8
          bind = $mainMod, 9, workspace, 9
          bind = $mainMod, 0, workspace, 10

      #Move active window in directions 
          bind = $mainMod SHIFT, left, movewindow, l
          bind = $mainMod SHIFT, right, movewindow, r
          bind = $mainMod SHIFT, up, movewindow, u
          bind = $mainMod SHIFT, down, movewindow, d
          bind = $mainMod SHIFT, l, movewindow, r
          bind = $mainMod SHIFT, h, movewindow, l
          bind = $mainMod SHIFT, k, movewindow, u
          bind = $mainMod SHIFT, j, movewindow, d


      # Move active window to a workspace with mainMod + SHIFT + [0-9]
          bind = $mainMod SHIFT, 1, movetoworkspace, 1
          bind = $mainMod SHIFT, 2, movetoworkspace, 2
          bind = $mainMod SHIFT, 3, movetoworkspace, 3
          bind = $mainMod SHIFT, 4, movetoworkspace, 4
          bind = $mainMod SHIFT, 5, movetoworkspace, 5
          bind = $mainMod SHIFT, 6, movetoworkspace, 6
          bind = $mainMod SHIFT, 7, movetoworkspace, 7
          bind = $mainMod SHIFT, 8, movetoworkspace, 8
          bind = $mainMod SHIFT, 9, movetoworkspace, 9
          bind = $mainMod SHIFT, 0, movetoworkspace, 10

      #moveworkspacetocurrentmonitor
          bind =  Win, 1, focusworkspaceoncurrentmonitor, 1
          bind =  Win, 2, focusworkspaceoncurrentmonitor, 2
          bind =  Win, 3, focusworkspaceoncurrentmonitor, 3
          bind =  Win, 4, focusworkspaceoncurrentmonitor, 4
          bind =  Win, 5, focusworkspaceoncurrentmonitor, 5
          bind =  Win, 6, focusworkspaceoncurrentmonitor, 6
          bind =  Win, 7, focusworkspaceoncurrentmonitor, 7
          bind =  Win, 8, focusworkspaceoncurrentmonitor, 8
          bind =  Win, 9, focusworkspaceoncurrentmonitor, 9
          bind =  Win, 0, focusworkspaceoncurrentmonitor, 10


      #switch layouts
          bind = $mainMod, I, exec, $scripts/toggleLayout

      # Example special workspace (scratchpad)
          bind = $mainMod, S, togglespecialworkspace, terminal
          bind = $mainMod SHIFT, S, movetoworkspace, special:terminal
          bind = $mainMod, T, togglespecialworkspace, telegram
          bind = $mainMod SHIFT, T, movetoworkspace, special:telegram

      # Scroll through existing workspaces with mainMod + scroll
          bind = $mainMod, mouse_down, workspace, e+1
          bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
          bindm = $mainMod, mouse:272, movewindow
          bindm = $mainMod, mouse:273, resizewindow

      #kill animations and other stuff for performance
          bind = $mainMod, F1, exec, $scripts/performance.sh
          bind = $mainMod, F2, exec, $scripts/gapsoff.sh

          workspace=special:telegram, decorate:false, border:false, on-created-empty:$telegram #gapsin:0, gapsout:0
          workspace=special:terminal, on-created-empty: $terminal -o background_opacity=0.6, 
          workspace=1, monitor:eDP-1
          workspace=2, monitor:eDP-1
          workspace=3, monitor:eDP-1
          workspace=4, monitor:eDP-1
          workspace=5, monitor:eDP-1
          workspace=6, monitor:HDMI-A-1
          workspace=7, monitor:HDMI-A-1
          workspace=8, monitor:HDMI-A-1
          workspace=9, monitor:HDMI-A-1
          workspace=10, monitor:HDMI-A-1

      # windowrulev2 =  centered, floating:1
          windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.
          windowrulev2 = workspace special:telegram, class:(org.telegram.desktop.*)
          windowrulev2 =   size 95% 95%, class:(btop) 
          windowrulev2 =   float, class:(btop) 
          windowrulev2 = float, class:(files) 
          windowrulev2 = size 60% 60%, centered, title:(.*Files)$
      # windowrulev2 = size 50% 50%, centered, floating:1
          windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
      # windowrulev2 = opacity 0.89 override 0.89 override,class:(floorp)
          windowrulev2 = noanim,class:^(xwaylandvideobridge)$
          windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$
          windowrulev2 = maxsize 1 1,class:^(xwaylandvideobridge)$
          windowrulev2 = noblur,class:^(xwaylandvideobridge)$
          windowrulev2 = float, class:(clipse)
          windowrulev2 = size 622 652, class:(clipse)

        '';


    settings = {
      "$mainMod" = "SUPER";

      monitor=",preferred, auto, 1";

      env = [
        "XCURSOR_SIZE, 30"
      ];

      input = {
        kb_layout = "us,ua,ru";
        # kb_variant = "dvorak";
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
        initial_workspace_tracking= false;
      };

      general = {
        gaps_in = 5;
        gaps_out = 15;
        border_size = 3;

        "col.active_border" = "rgba(EEEEFFFF)";
        "col.inactive_border" = "rgba(1C254100)";

        layout = "dwindle";
      };

      decoration = {
        rounding = 5;
        
        blur = {
          enabled = true;
          size = 3;
          passes = 3;
        };
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier, slide"
          "windowsOut, 1, 7, default, slide"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
          "specialWorkspace, 1, 7, default, slidevert"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        no_gaps_when_only = false;
      };

      master = {
        no_gaps_when_only = true;
      };

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "dotoold"
        "ls ~/.config/wpaperd/config.toml | entr -r wpaperd"
        "waybar"
        "pipx ensurepath"
        "clipse -listen"
      ];


    };

  };

}

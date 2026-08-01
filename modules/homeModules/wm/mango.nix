{ self, inputs, ... }:
{
  flake.homeModules.mango =
    {
      config,
      pkgs,
      lib,
      myopts,
      system,
      ...
    }:
    let
      monitors =
        if myopts.monitors == null then
          [
            {
              name = "none";
              config = "none";
            }
          ]
        else
          myopts.monitors;

      isLaptop = myopts.nh.host == "laptop";
      isLab = myopts.nh.host == "lab";
      browser = if myopts.browser == null then "" else lib.getExe myopts.browser;
      brightnessctl = lib.getExe pkgs.brightnessctl;
      grim = lib.getExe pkgs.grim;
      slurp = lib.getExe pkgs.slurp;
      wlCopy = "${pkgs.wl-clipboard}/bin/wl-copy";
      notifySend = lib.getExe pkgs.libnotify;
      hyprpicker = lib.getExe pkgs.hyprpicker;
      ncpamixer = lib.getExe pkgs.ncpamixer;
      btop = lib.getExe pkgs.btop;
      tesseract = lib.getExe pkgs.tesseract;

      screenshotDir = "${config.home.homeDirectory}/Pictures/Screenshots";

      # Workspace (tag) view binds, 1..9
      # mango: view,N,0 → switch to tag N; tag,N,0 → move client to tag N
      workspaceBinds = builtins.concatStringsSep "\n" (
        builtins.genList (
          i:
          let
            ws = toString (i + 1);
          in
          ''
            bind=SUPER,${ws},view,${ws},0
            bind=SUPER+SHIFT,${ws},tag,${ws},0
            bind=SUPER+ALT,${ws},view,${ws},0
          ''
        ) 9
      );



      scriptDefs = self.lib.wm-scripts {
        pkgs = pkgs;
        monitors = monitors;
        myopts = myopts;
      };

      monitorNames = map (m: m.name) monitors;

      # Tag rules and bindings for multi-monitor setup (Discussion #469)
      # Tags 1-5 fixed to Monitor 1 (left), Tags 6-10 fixed to Monitor 2 (right)
      tagRulesAndBinds =
        if myopts.monitors != null && builtins.length monitorNames >= 2 then
          let
            m0 = builtins.elemAt monitorNames 0;
            m1 = builtins.elemAt monitorNames 1;
          in
          ''
            # Monitor 1 (Left): Tags 1..5
            tagrule=id:1,monitor_name:${m0},no_hide:1,layout_name:tile
            tagrule=id:2,monitor_name:${m0},no_hide:1,layout_name:tile
            tagrule=id:3,monitor_name:${m0},no_hide:1,layout_name:tile
            tagrule=id:4,monitor_name:${m0},no_hide:1,layout_name:tile
            tagrule=id:5,monitor_name:${m0},no_hide:1,layout_name:tile

            # Monitor 2 (Right): Tags 6..10
            tagrule=id:6,monitor_name:${m1},no_hide:1,layout_name:tile
            tagrule=id:7,monitor_name:${m1},no_hide:1,layout_name:tile
            tagrule=id:8,monitor_name:${m1},no_hide:1,layout_name:tile
            tagrule=id:9,monitor_name:${m1},no_hide:1,layout_name:tile
            tagrule=id:10,monitor_name:${m1},no_hide:1,layout_name:tile

            # View tags & auto-launch assigned apps
            bind=SUPER,1,spawn,sh -c "mmsg dispatch viewcrossmon,1,${m0} 2>/dev/null || true; pgrep -i 'telegram' >/dev/null || Telegram"
            bind=SUPER,2,spawn,sh -c "mmsg dispatch viewcrossmon,2,${m0} 2>/dev/null || true; pgrep -i 'keepassxc' >/dev/null || keepassxc"
            bind=SUPER,3,spawn,sh -c "mmsg dispatch viewcrossmon,3,${m0} 2>/dev/null || true; pgrep -i 'youtube_music|ytmdesktop' >/dev/null || ytmdesktop"
            bind=SUPER,4,spawn,sh -c "mmsg dispatch viewcrossmon,4,${m0} 2>/dev/null || true; pgrep -i 'vesktop' >/dev/null || vesktop"
            bind=SUPER,5,spawn,sh -c "mmsg dispatch viewcrossmon,5,${m0} 2>/dev/null || true; pgrep -i 'teams' >/dev/null || teams-for-linux"
            bind=SUPER,6,spawn,sh -c "mmsg dispatch viewcrossmon,6,${m1} 2>/dev/null || true; pgrep -i 'firefox|chromium|brave|floorp|zen|vivaldi' >/dev/null || ${browser}"
            bind=SUPER,7,viewcrossmon,7,${m1}
            bind=SUPER,8,spawn,sh -c "mmsg dispatch viewcrossmon,8,${m1} 2>/dev/null || true; pgrep -i 'steam' >/dev/null || steam"
            bind=SUPER,9,viewcrossmon,9,${m1}
            bind=SUPER,0,viewcrossmon,10,${m1}

            # App shortcuts
            bind=SUPER,t,spawn,sh -c "mmsg dispatch viewcrossmon,1,${m0} 2>/dev/null || true; pgrep -i 'telegram' >/dev/null || Telegram"
            bind=SUPER,w,spawn,sh -c "mmsg dispatch viewcrossmon,6,${m1} 2>/dev/null || true; pgrep -i 'firefox|chromium|brave|floorp|zen|vivaldi' >/dev/null || ${browser}"

            # Move active window to tag
            bind=SUPER+SHIFT,1,tag,1,0
            bind=SUPER+SHIFT,2,tag,2,0
            bind=SUPER+SHIFT,3,tag,3,0
            bind=SUPER+SHIFT,4,tag,4,0
            bind=SUPER+SHIFT,5,tag,5,0
            bind=SUPER+SHIFT,6,tag,6,0
            bind=SUPER+SHIFT,7,tag,7,0
            bind=SUPER+SHIFT,8,tag,8,0
            bind=SUPER+SHIFT,9,tag,9,0
            bind=SUPER+SHIFT,0,tag,10,0

            # Super+Alt+N views tag on current focused monitor
            bind=SUPER+ALT,1,view,1,0
            bind=SUPER+ALT,2,view,2,0
            bind=SUPER+ALT,3,view,3,0
            bind=SUPER+ALT,4,view,4,0
            bind=SUPER+ALT,5,view,5,0
            bind=SUPER+ALT,6,view,6,0
            bind=SUPER+ALT,7,view,7,0
            bind=SUPER+ALT,8,view,8,0
            bind=SUPER+ALT,9,view,9,0
            bind=SUPER+ALT,0,view,10,0
          ''
        else
          ''
            # Single monitor / default fallback
            ${workspaceBinds}
            bind=SUPER,0,view,10,0
            bind=SUPER+SHIFT,0,tag,10,0
            bind=SUPER+ALT,0,view,10,0
          '';

      # Window rules for app tags and monitors
      windowAppRules =
        if myopts.monitors != null && builtins.length monitorNames >= 2 then
          let
            m0 = builtins.elemAt monitorNames 0;
            m1 = builtins.elemAt monitorNames 1;
          in
          ''
            # Telegram (Tag 1 -> Monitor 0)
            windowrule=appid:org.telegram.desktop,tags:1,monitor:${m0}
            windowrule=appid:telegram-desktop,tags:1,monitor:${m0}
            windowrule=appid:TelegramDesktop,tags:1,monitor:${m0}
            windowrule=appid:Telegram,tags:1,monitor:${m0}
            windowrule=appid:.*telegram.*,tags:1,monitor:${m0}

            # KeePassXC (Tag 2 -> Monitor 0)
            windowrule=appid:org.keepassxc.KeePassXC,tags:2,monitor:${m0}
            windowrule=appid:keepassxc,tags:2,monitor:${m0}
            windowrule=appid:KeePassXC,tags:2,monitor:${m0}

            # YouTube Music (Tag 3 -> Monitor 0)
            windowrule=appid:youtube_music,tags:4,monitor:${m0}
            windowrule=appid:ytmdesktop,tags:4,monitor:${m0}

            # Vesktop (Tag 4 -> Monitor 0)
            windowrule=appid:vesktop,tags:8,monitor:${m0}

            # Teams (Tag 5 -> Monitor 0)
            windowrule=appid:teams-for-linux,tags:16,monitor:${m0}

            # Browser (Tag 6 -> Monitor 1)
            windowrule=appid:zen,tags:32,monitor:${m1}
            windowrule=appid:zen-alpha,tags:32,monitor:${m1}
            windowrule=appid:zen-twilight,tags:32,monitor:${m1}
            windowrule=appid:firefox,tags:32,monitor:${m1}
            windowrule=appid:chromium-browser,tags:32,monitor:${m1}
            windowrule=appid:brave-browser,tags:32,monitor:${m1}
            windowrule=appid:floorp,tags:32,monitor:${m1}
            windowrule=appid:vivaldi-stable,tags:32,monitor:${m1}

            # Steam (Tag 8 -> Monitor 1)
            windowrule=appid:steam,tags:128,monitor:${m1}
            windowrule=appid:Steam,tags:128,monitor:${m1}

            # Steam Apps (Tag 9 -> Monitor 1)
            windowrule=appid:steam_app_.*,tags:256,monitor:${m1}

            # MPV (Tag 10 -> Monitor 1)
            windowrule=appid:mpv,tags:512,monitor:${m1}
          ''
        else
          ''
            # Single monitor fallback
            windowrule=appid:org.telegram.desktop,tags:1
            windowrule=appid:telegram-desktop,tags:1
            windowrule=appid:TelegramDesktop,tags:1
            windowrule=appid:Telegram,tags:1
            windowrule=appid:.*telegram.*,tags:1

            windowrule=appid:org.keepassxc.KeePassXC,tags:2
            windowrule=appid:keepassxc,tags:2
            windowrule=appid:KeePassXC,tags:2

            windowrule=appid:youtube_music,tags:4
            windowrule=appid:ytmdesktop,tags:4

            windowrule=appid:vesktop,tags:8

            windowrule=appid:teams-for-linux,tags:16

            windowrule=appid:zen,tags:32
            windowrule=appid:zen-alpha,tags:32
            windowrule=appid:zen-twilight,tags:32
            windowrule=appid:firefox,tags:32
            windowrule=appid:chromium-browser,tags:32
            windowrule=appid:brave-browser,tags:32
            windowrule=appid:floorp,tags:32
            windowrule=appid:vivaldi-stable,tags:32

            windowrule=appid:steam,tags:128
            windowrule=appid:Steam,tags:128

            windowrule=appid:steam_app_.*,tags:256

            windowrule=appid:mpv,tags:512
          '';

      tmuxInitScript = lib.getExe scriptDefs.tmuxInitScript;
      forceKillScript = lib.getExe scriptDefs.forceKillScript;
    in
    {
      imports = [ inputs.mango.hmModules.mango ];

      services.poweralertd.enable = true;

      wayland.windowManager.mango = {
        enable = true;

        systemd = {
          enable = true;
          variables = [ "--all" ];
        };

        autostart_sh = ''
          dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP GTK_USE_PORTAL
          ${tmuxInitScript} &
          wpaperd &
        '';

        settings = {
          # Input — keyboard
          # mango only accepts a single layout in xkb_rules_layout;
          # multi-layout cycling must be done via spawn + setxkbmap / ydotool / etc.
          xkb_rules_layout = "us";
          repeat_delay = 250;
          repeat_rate = 25;

          # Input — trackpad
          tap_to_click = 1;
          trackpad_natural_scrolling = 1;
          disable_while_typing = 1;

          # Appearance
          # gaps: ih=inner-horizontal, iv=inner-vertical, oh=outer-h, ov=outer-v
          gappih = 5;
          gappiv = 5;
          gappoh = 15;
          gappov = 15;
          borderpx = 3;
          border_radius = 5;
          blur = 0;
          animations = 0;
          focused_opacity = 1.0;
          unfocused_opacity = 1.0;

          # Smart gaps & single window settings
          smartgaps = 1;
          no_border_when_single = 1;
          no_radius_when_single = 1;

          # Misc & Scratchpad
          focus_cross_monitor = 1;
          scratchpad_width_ratio = 1.0;
          scratchpad_height_ratio = 1.0;
          sloppyfocus = 1;
          warpcursor = 1;
        };

        extraConfig = ''
          # === Environment ===
          env=XDG_CURRENT_DESKTOP,mango
          env=XCURSOR_SIZE,30
          env=NIXOS_OZONE_WL,1

          # === Keybindings ===
          # Modifier syntax: SUPER, ALT, CTRL, SHIFT, NONE
          # Combos: SUPER+SHIFT, SUPER+CTRL, ALT+SHIFT, etc.

          # Reload config
          bind=SUPER,F5,reload_config

          # Terminal launches
          bind=SUPER,Return,spawn,kitty -1
          bind=SUPER+SHIFT,Return,spawn,kitty -1 -o background_opacity=0.4
          bind=SUPER,a,spawn,kitty -1 --app-id fl ${ncpamixer}
          bind=SUPER,u,spawn,kitty -1 --app-id fl ${btop}

          # Browser / apps
          bind=SUPER+CTRL,w,spawn,${browser}
          bind=SUPER,e,spawn,${lib.getExe pkgs.nemo} --class files
          bind=SUPER+CTRL,p,spawn,pear-desktop

          # Color picker
          bind=NONE,F10,spawn,wl-copy $(${hyprpicker})

          # Vicinae deeplinks
          bind=SUPER,d,spawn,vicinae vicinae://toggle
          bind=SUPER,c,spawn,vicinae vicinae://launch/clipboard/history
          bind=SUPER,space,spawn,vicinae vicinae://launch/wm/switch-windows

          # Wallpaper cycling
          bind=SUPER,F6,spawn,wpaperctl next-wallpaper
          bind=SUPER,F4,spawn,wpaperctl previous-wallpaper

          # Screenshots
          bind=NONE,Print,spawn,sh -c "${grim} -g \"$(${slurp})\" - | ${wlCopy}"
          bind=SUPER,Print,spawn,sh -c "mkdir -p '${screenshotDir}' && ${grim} \"${screenshotDir}/screenshot_$(date +%Y%m%d_%H%M%S).png\" && ${notifySend} -t 2000 'Screenshot Saved'"
          bind=SUPER,o,spawn,sh -c "${wlCopy} < <(${grim} -g \"$(${slurp})\" - | ${tesseract} stdin stdout)"

          # Window management
          bind=ALT,q,killclient
          bind=SUPER,q,killclient
          bind=ALT,backslash,togglefloating
          bind=SUPER,v,togglefloating
          bind=ALT,f,togglefullscreen
          bind=SUPER,f,togglefullscreen

          # Logout / force kill
          bind=SUPER,Escape,spawn,wlogout
          bind=SUPER+SHIFT,q,spawn,${forceKillScript}

          # Volume
          bind=NONE,XF86AudioRaiseVolume,spawn,pactl set-sink-volume @DEFAULT_SINK@ +10%
          bind=NONE,XF86AudioLowerVolume,spawn,pactl set-sink-volume @DEFAULT_SINK@ -10%
          bind=NONE,XF86AudioMute,spawn,pactl set-sink-mute @DEFAULT_SINK@ toggle
          bind=SUPER,KP_Up,spawn,pactl set-sink-volume @DEFAULT_SINK@ +10%
          bind=SUPER,KP_Down,spawn,pactl set-sink-volume @DEFAULT_SINK@ -10%
          bind=SUPER,KP_Begin,spawn,pactl set-sink-mute @DEFAULT_SINK@ toggle

          # Brightness
          bind=NONE,XF86MonBrightnessUp,spawn,${brightnessctl} set +10%
          bind=NONE,XF86MonBrightnessDown,spawn,${brightnessctl} set 10%-

          # Focus movement
          bind=SUPER,Up,focusdir,up
          bind=SUPER,Down,focusdir,down
          bind=SUPER,Left,focusdir,left
          bind=SUPER,Right,focusdir,right
          bind=SUPER,k,focusdir,up
          bind=SUPER,j,focusdir,down
          bind=SUPER,h,focusdir,left
          bind=SUPER,l,focusdir,right

          # Move windows (exchange_client moves tiled windows directionally)
          bind=SUPER+SHIFT,Left,exchange_client,left
          bind=SUPER+SHIFT,Right,exchange_client,right
          bind=SUPER+SHIFT,Up,exchange_client,up
          bind=SUPER+SHIFT,Down,exchange_client,down
          bind=SUPER+SHIFT,h,exchange_client,left
          bind=SUPER+SHIFT,l,exchange_client,right
          bind=SUPER+SHIFT,k,exchange_client,up
          bind=SUPER+SHIFT,j,exchange_client,down

          # Monitor movement
          bind=SUPER+ALT,Left,focusmon,left
          bind=SUPER+ALT,Right,focusmon,right
          bind=SUPER+ALT,h,focusmon,left
          bind=SUPER+ALT,l,focusmon,right
          bind=SUPER+ALT+SHIFT,Left,tagmon,left
          bind=SUPER+ALT+SHIFT,Right,tagmon,right
          bind=SUPER+ALT+SHIFT,h,tagmon,left
          bind=SUPER+ALT+SHIFT,l,tagmon,right

          # Mouse binds — move and resize windows
          mousebind=SUPER,btn_left,moveresize,curmove
          mousebind=SUPER,btn_right,moveresize,curresize

          # Tag rules and bindings (Multi-monitor / single fallback)
          ${tagRulesAndBinds}

          # Scratchpad terminal (toggle named scratchpad running tmux attach)
          bind=SUPER,s,toggle_named_scratchpad,terminal-scratch,none,kitty --class terminal-scratch tmux attach

          # Keyboard layout switching via setxkbmap
          bind=SUPER+SHIFT,e,spawn,setxkbmap us
          bind=SUPER+SHIFT,u,spawn,setxkbmap ua
          bind=SUPER+SHIFT,r,spawn,setxkbmap ru
          bind=SUPER+SHIFT,p,spawn,setxkbmap pl

          # Resize submap mode (Super+R enters resize mode, Escape/Return exits)
          bind=SUPER,r,setkeymode,resize
          keymode=resize
          bind=NONE,Right,resizewin,30,0
          bind=NONE,Left,resizewin,-30,0
          bind=NONE,Up,resizewin,0,-30
          bind=NONE,Down,resizewin,0,30
          bind=NONE,l,resizewin,30,0
          bind=NONE,h,resizewin,-30,0
          bind=NONE,k,resizewin,0,-30
          bind=NONE,j,resizewin,0,30
          bind=NONE,Escape,setkeymode,default
          bind=NONE,Return,setkeymode,default
          bind=SUPER,r,setkeymode,default
          keymode=default

          # Window rules
          # Format: windowrule=appid:REGEX[,title:REGEX][,param:val,...]
          # tags uses bitmask: tag N = 2^(N-1)
          # tag 1=1, 2=2, 3=4, 4=8, 5=16, 6=32, 7=64, 8=128, 9=256, 10=512
          windowrule=isnamedscratchpad:1,isfullscreen:1,appid:terminal-scratch
          windowrule=appid:fl,isfloating:1
          windowrule=appid:files,isfloating:1

          # Application Tag & Monitor Rules
          ${windowAppRules}
        '';
      };
    };
}

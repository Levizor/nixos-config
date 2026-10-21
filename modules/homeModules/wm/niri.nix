{ self, inputs, ... }:
{
  flake.homeModules.niri =
    {
      lib,
      pkgs,
      system,
      myopts,
      ...
    }:
    let
      browser = if myopts.browser == null then null else lib.getExe myopts.browser;
      browserCmd = if browser != null then browser else "zen";

      monitors = if myopts.monitors != null then myopts.monitors else [ ];
      mon0 = if builtins.length monitors > 0 then (builtins.elemAt monitors 0).name else null;
      mon1 = if builtins.length monitors > 1 then (builtins.elemAt monitors 1).name else mon0;

      scriptDefs = self.lib.wm-scripts {
        pkgs = pkgs;
        monitors = monitors;
        myopts = myopts;
      };
      forceKillScript = lib.getExe scriptDefs.forceKillScript;

      outputConfigKdl =
        if mon0 != null && mon1 != null && mon0 != mon1 then ''
          output "${mon0}" {
              position x=0 y=0
          }
          output "${mon1}" {
              position x=1920 y=0
          }
        '' else if mon0 != null then ''
          output "${mon0}" {
              position x=0 y=0
          }
        '' else "";



    in
    {
      home.packages = [
        inputs.niri-scratchpad.packages.${system}.default
        pkgs.wl-kbptr
      ];

      wayland.windowManager.niri = {
        enable = true;
        extraConfig = ''
          input {
              keyboard {
                  xkb {
                      layout "us,ua,ru,pl"
                      // options "grp:alt_shift_toggle"
                  }
              }

              touchpad {
                  tap
                  natural-scroll
                  scroll-method "two-finger"
              }

              mouse {
              }

              warp-mouse-to-focus

              focus-follows-mouse max-scroll-amount="0%"
          }

          layout {
              gaps 10

              center-focused-column "never"

              preset-column-widths {
                  proportion 0.33333
                  proportion 0.5
                  proportion 0.66667
              }

              default-column-width {
                  proportion 0.5 
              }

              focus-ring {
                  width 4
                  active-color "#7fc8ff"
                  inactive-color "#505050"
              }

              shadow {
                  softness 30
                  spread 5
                  offset x=0 y=5
                  color "#0007"
              }

              struts {
              }
          }

          spawn-at-startup "noctalia"

          // Output positioning
          ${outputConfigKdl}

          // Workspaces
          workspace "main" { }
          workspace "2" {
              ${if mon1 != null then "open-on-output \"${mon1}\"" else ""}
          }
          workspace "stash" {
              ${if mon1 != null then "open-on-output \"${mon1}\"" else ""}
          }

          hotkey-overlay {
              skip-at-startup
          }

          screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

          prefer-no-csd

          window-rule {
              draw-border-with-background false
          }

          animations {
          }

          // WezTerm initial configure workaround
          window-rule {
              match app-id=r#"^org\.wezfurlong\.wezterm$"#
              default-column-width {}
          }

          // Firefox PiP floating
          window-rule {
              match app-id=r#"firefox$"# title="^Picture-in-Picture$"
              open-floating true
          }

          // Block password managers from screen capture
          window-rule {
              match app-id=r#"^org\.keepassxc\.KeePassXC$"#
              match app-id=r#"^org\.gnome\.World\.Secrets$"#
              block-out-from "screen-capture"
          }

          // === Default Window Rule ===
          window-rule {
              // open-maximized true
          }

          // === Window Rules ===

          // Workspace 1: Telegram
          window-rule {
              match app-id=r#"(?i).*(telegram).*"#
              open-on-workspace "1"
              ${if mon0 != null then "open-on-output \"${mon0}\"" else ""}
          }

          // Workspace 2: KeePassXC
          window-rule {
              match app-id=r#"(?i).*(keepassxc).*"#
              open-on-workspace "2"
              ${if mon0 != null then "open-on-output \"${mon0}\"" else ""}
          }

          // Workspace 3: YouTube Music
          window-rule {
              match app-id=r#"(?i).*(youtube_music|ytmdesktop).*"#
              open-on-workspace "3"
              ${if mon0 != null then "open-on-output \"${mon0}\"" else ""}
          }

          // Workspace 4: Vesktop / Discord
          window-rule {
              match app-id=r#"^vesktop$"#
              open-on-workspace "4"
              ${if mon0 != null then "open-on-output \"${mon0}\"" else ""}
          }

          // Workspace 5: Teams
          window-rule {
              match app-id=r#"^teams-for-linux$"#
              open-on-workspace "5"
              ${if mon0 != null then "open-on-output \"${mon0}\"" else ""}
          }

          // Workspace 2: Browser (Maximized / Fullscreen on Second Monitor)
          window-rule {
              match app-id=r#"(?i).*(firefox|chromium|brave|floorp|zen|vivaldi).*"#
              open-on-workspace "2"
              open-maximized true
              ${if mon1 != null then "open-on-output \"${mon1}\"" else ""}
          }

          // Workspace 8: Steam
          window-rule {
              match app-id=r#"^steam$"#
              open-on-workspace "8"
              ${if mon1 != null then "open-on-output \"${mon1}\"" else ""}
          }

          // Games & QEMU
          window-rule {
              match app-id=r#"^steam_app_.*$"#
              open-on-workspace "9"
              ${if mon1 != null then "open-on-output \"${mon1}\"" else ""}
          }
          window-rule {
              match app-id=r#".*(qemu).*"#
              open-on-workspace "9"
              ${if mon1 != null then "open-on-output \"${mon1}\"" else ""}
          }

          // MPV / Media
          window-rule {
              match app-id=r#"^mpv$"#
              open-on-workspace "10"
              ${if mon1 != null then "open-on-output \"${mon1}\"" else ""}
          }

          // Scratchpad terminal window rule
          window-rule {
              match app-id="scratchpad-term"
              open-floating true
              default-column-width { proportion 1.0; }
              default-window-height { proportion 1.0; }
              border { off; }
          }

          // steam notification toasts
          // window-rule {
          //    match app-id="steam" title="^notificationtoasts"
          //    open-floating true
          //}
          // or using the newer regex style format depending on your version:
          //window-rule {
          //    match app-id=r#"^steam$"# title=r#"^notificationtoasts"#
          //    open-floating true
          //}

          binds {
              Mod+Shift+Slash { show-hotkey-overlay; }

              // --- Launchers & apps ---
              Mod+Return hotkey-overlay-title="Open Terminal: kitty" { spawn "kitty" "-1"; }
              Mod+Shift+Return { spawn-sh "kitty -1 -o background_opacity=0.4"; }
              Mod+D hotkey-overlay-title="Open launcher: noctalia" { spawn "noctalia" "msg" "panel-toggle" "launcher"; }
              Mod+A hotkey-overlay-title="Audio mixer: ncpamixer" { spawn "kitty" "--app-id" "fl" "ncpamixer"; }
              Mod+Ctrl+Alt+B hotkey-overlay-title="System monitor: btop" { spawn "kitty" "--app-id" "fl" "btop"; }

              // Apps
              Mod+T repeat=false hotkey-overlay-title="Telegram Workspace & App" {
                  spawn-sh "wid=$(niri msg -j windows | ${pkgs.jq}/bin/jq -r '.[] | select(.app_id != null) | select(.app_id | test(\"telegram\"; \"i\")) | .id' | head -n1); if [ -n \"$wid\" ]; then niri msg action focus-window --id \"$wid\"; else Telegram & fi";
              }
              Mod+W repeat=false hotkey-overlay-title="Browser Workspace & App" {
                  spawn-sh "wid=$(niri msg -j windows | ${pkgs.jq}/bin/jq -r '.[] | select(.app_id != null) | select(.app_id | test(\"zen|firefox|chromium|brave|floorp|vivaldi\"; \"i\")) | .id' | head -n1); if [ -n \"$wid\" ]; then niri msg action focus-window --id \"$wid\"; else ${browserCmd} & fi";
              }

              // --- Noctalia ---
              Mod+Space hotkey-overlay-title="Switch windows: noctalia" { spawn "noctalia" "msg" "panel-toggle" "window-switcher"; }
              Mod+C hotkey-overlay-title="Clipboard history: noctalia" { spawn "noctalia" "msg" "panel-toggle" "clipboard"; }

              // --- Scratchpad terminal ---
              Mod+S repeat=false hotkey-overlay-title="Scratchpad terminal" {
                  spawn "niri-scratchpad" "target" "--spawn" "kitty --class scratchpad-term sh -c \"tmux attach || tmux\"" "--as-float" "appid" "scratchpad-term";
              }
              Mod+Shift+S repeat=false hotkey-overlay-title="Send to scratchpad" {
                  spawn "niri-scratchpad" "create" "1";
              }

              // --- Logout / session ---
              Super+Escape hotkey-overlay-title="Logout: wlogout" { spawn "noctalia" "msg" "panel-toggle" "session"; }

              // --- Wallpaper ---
              Mod+F6 { spawn "wpaperctl" "next-wallpaper"; }
              Mod+F4 { spawn "wpaperctl" "previous-wallpaper"; }

              // --- Misc tools ---
              F10 hotkey-overlay-title="Color picker" { spawn-sh "wl-copy $(hyprpicker)"; }
              Mod+Shift+O hotkey-overlay-title="OCR clipboard image" { spawn-sh "wl-paste | tesseract stdin stdout | wl-copy"; }

              // wl-kbptr
              Mod+Alt+T { spawn-sh "killall -q wl-kbptr; wl-kbptr -o modes=tile"; }
              Mod+Alt+P { spawn-sh "killall -q wl-kbptr; wl-kbptr -o modes=floating,click -o mode_floating.source=detect"; }
              Mod+Alt+X { spawn-sh "killall -q wl-kbptr"; }

              // --- Volume ---
              XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"; }
              XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
              XF86AudioMute        allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
              XF86AudioMicMute     allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
              Mod+KP_Up    allow-when-locked=true { spawn-sh "pactl set-sink-volume @DEFAULT_SINK@ +10%"; }
              Mod+KP_Down  allow-when-locked=true { spawn-sh "pactl set-sink-volume @DEFAULT_SINK@ -10%"; }
              Mod+KP_Begin allow-when-locked=true { spawn-sh "pactl set-sink-mute @DEFAULT_SINK@ toggle"; }

              // --- Media ---
              XF86AudioPlay allow-when-locked=true { spawn-sh "playerctl play-pause"; }
              XF86AudioStop allow-when-locked=true { spawn-sh "playerctl stop"; }
              XF86AudioPrev allow-when-locked=true { spawn-sh "playerctl previous"; }
              XF86AudioNext allow-when-locked=true { spawn-sh "playerctl next"; }

              // --- Brightness ---
              XF86MonBrightnessUp   allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
              XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }

              // --- Screenshots (Noctalia) ---
              Print { spawn "noctalia" "msg" "screenshot-region"; }
              Ctrl+Print { spawn "noctalia" "msg" "screenshot-fullscreen"; }
              Alt+Print { spawn "noctalia" "msg" "screenshot-fullscreen" "pick"; }
              Mod+Print { spawn "noctalia" "msg" "screenshot-region"; }

              // --- Keyboard layout switching ---
              Alt+Space repeat=false { switch-layout "next"; }
              Mod+Alt+Space repeat=false { switch-layout "next"; }
              Mod+Shift+E { switch-layout "0"; }
              Mod+Shift+U { switch-layout "1"; }
              Mod+Shift+R { switch-layout "2"; }
              Mod+Shift+P { switch-layout "3"; }

              // --- Window management ---
              Mod+Q repeat=false { close-window; }
              Mod+V       { toggle-window-floating; }
              Mod+Shift+V { switch-focus-between-floating-and-tiling; }
              Mod+F { maximize-column; }
              Mod+Shift+F { fullscreen-window; }
              Mod+M { maximize-window-to-edges; }
              Mod+O repeat=false { toggle-overview; }

              // --- Focus movement ---
              Mod+Left  { focus-column-or-monitor-left; }
              Mod+Down  { focus-window-or-workspace-down; }
              Mod+Up    { focus-window-or-workspace-up; }
              Mod+Right { focus-column-or-monitor-right; }
              Mod+H     { focus-column-or-monitor-left; }
              Mod+J     { focus-window-or-workspace-down; }
              Mod+K     { focus-window-or-workspace-up; }
              Mod+L     { focus-column-or-monitor-right; }

              // --- Focus monitor ---
              Mod+Alt+Left  { focus-monitor-left; }
              Mod+Alt+Down  { focus-monitor-down; }
              Mod+Alt+Up    { focus-monitor-up; }
              Mod+Alt+Right { focus-monitor-right; }
              Mod+Alt+H     { focus-monitor-left; }
              Mod+Alt+J     { focus-monitor-down; }
              Mod+Alt+K     { focus-monitor-up; }
              Mod+Alt+L     { focus-monitor-right; }

              // --- Move windows / columns ---
              Mod+Shift+Left  { move-column-left-or-to-monitor-left; }
              Mod+Shift+Down  { move-window-down-or-to-workspace-down; }
              Mod+Shift+Up    { move-window-up-or-to-workspace-up; }
              Mod+Shift+Right { move-column-right-or-to-monitor-right; }
              Mod+Shift+H     { move-column-left-or-to-monitor-left; }
              Mod+Shift+J     { move-window-down-or-to-workspace-down; }
              Mod+Shift+K     { move-window-up-or-to-workspace-up; }
              Mod+Shift+L     { move-column-right-or-to-monitor-right; }

              // --- Move columns ---
              Mod+Ctrl+Left  { move-column-left; }
              Mod+Ctrl+Down  { move-window-down; }
              Mod+Ctrl+Up    { move-window-up; }
              Mod+Ctrl+Right { move-column-right; }
              Mod+Ctrl+H     { move-column-left; }
              Mod+Ctrl+J     { move-window-down; }
              Mod+Ctrl+K     { move-window-up; }
              Mod+Ctrl+L     { move-column-right; }

              Mod+Home      { focus-column-first; }
              Mod+End       { focus-column-last; }
              Mod+Ctrl+Home { move-column-to-first; }
              Mod+Ctrl+End  { move-column-to-last; }

              // --- Move to monitor ---
              Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
              Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
              Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
              Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
              Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
              Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
              Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
              Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

              // --- Workspaces ---
              Mod+Page_Down      { focus-workspace-down; }
              Mod+Page_Up        { focus-workspace-up; }
              Mod+U              { focus-workspace-down; }
              Mod+I              { focus-workspace-up; }
              Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
              Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
              Mod+Ctrl+U         { move-column-to-workspace-down; }
              Mod+Ctrl+I         { move-column-to-workspace-up; }

              Mod+Shift+Page_Down { move-workspace-down; }
              Mod+Shift+Page_Up   { move-workspace-up; }

              // Mouse wheel navigation
              Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
              Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
              Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
              Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

              Mod+WheelScrollRight      { focus-column-right; }
              Mod+WheelScrollLeft       { focus-column-left; }
              Mod+Ctrl+WheelScrollRight { move-column-right; }
              Mod+Ctrl+WheelScrollLeft  { move-column-left; }

              Mod+Shift+WheelScrollDown      { focus-column-right; }
              Mod+Shift+WheelScrollUp        { focus-column-left; }
              Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
              Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

              // Workspaces (Numeric 1-10)
              Mod+1 { focus-workspace 1; }
              Mod+2 { focus-workspace 2; }
              Mod+3 { focus-workspace 3; }
              Mod+4 { focus-workspace 4; }
              Mod+5 { focus-workspace 5; }
              Mod+6 { focus-workspace 6; }
              Mod+7 { focus-workspace 7; }
              Mod+8 { focus-workspace 8; }
              Mod+9 { focus-workspace 9; }
              Mod+0 { focus-workspace 10; }
              Mod+Shift+1 { move-column-to-workspace 1; }
              Mod+Shift+2 { move-column-to-workspace 2; }
              Mod+Shift+3 { move-column-to-workspace 3; }
              Mod+Shift+4 { move-column-to-workspace 4; }
              Mod+Shift+5 { move-column-to-workspace 5; }
              Mod+Shift+6 { move-column-to-workspace 6; }
              Mod+Shift+7 { move-column-to-workspace 7; }
              Mod+Shift+8 { move-column-to-workspace 8; }
              Mod+Shift+9 { move-column-to-workspace 9; }
              Mod+Shift+0 { move-column-to-workspace 10; }
              Mod+Ctrl+1 { move-column-to-workspace 1; }
              Mod+Ctrl+2 { move-column-to-workspace 2; }
              Mod+Ctrl+3 { move-column-to-workspace 3; }
              Mod+Ctrl+4 { move-column-to-workspace 4; }
              Mod+Ctrl+5 { move-column-to-workspace 5; }
              Mod+Ctrl+6 { move-column-to-workspace 6; }
              Mod+Ctrl+7 { move-column-to-workspace 7; }
              Mod+Ctrl+8 { move-column-to-workspace 8; }
              Mod+Ctrl+9 { move-column-to-workspace 9; }
              Mod+Ctrl+0 { move-column-to-workspace 10; }

              // --- Column / window layout ---
              Mod+BracketLeft  { consume-or-expel-window-left; }
              Mod+BracketRight { consume-or-expel-window-right; }
              Mod+Comma  { consume-window-into-column; }
              Mod+Period { expel-window-from-column; }

              Mod+R { switch-preset-column-width; }
              Mod+Ctrl+Shift+R { switch-preset-window-height; }
              Mod+Ctrl+R { reset-window-height; }

              Mod+Ctrl+F { expand-column-to-available-width; }

              // Note: Mod+C is noctalia clipboard; center uses Mod+Ctrl+C
              Mod+Ctrl+C { center-column; }
              Mod+Ctrl+Shift+C { center-visible-columns; }

              Mod+Minus       { set-column-width "-10%"; }
              Mod+Equal       { set-column-width "+10%"; }
              Mod+Shift+Minus { set-window-height "-10%"; }
              Mod+Shift+Equal { set-window-height "+10%"; }

              Mod+Shift+W { toggle-column-tabbed-display; }

              // --- Misc ---
              Mod+Shift+Q repeat=false hotkey-overlay-title="Force kill focused window" { spawn "${forceKillScript}"; }
              Ctrl+Alt+Delete { quit; }
              Mod+Ctrl+Alt+P { power-off-monitors; }
          }
        '';
      };
    };
}

{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    home.packages = with pkgs; [
      peaclock
      pulsemixer
      termdown
    ];
    programs.zellij = {
      enable = true;
      # enableZshIntegration = true;

      settings = {
        copy_command = "wl-copy";
        copy_clipboard = "system";
        pane_frames = false;
        on_force_close = "quit";
      };
    };

    xdg.configFile = {
      "zellij/config.kdl".text = ''
        keybinds {
          normal {
            bind "Ctrl x" {CloseFocus;}

            bind "Ctrl f" {
              LaunchOrFocusPlugin "https://github.com/imsnif/monocle/releases/latest/download/monocle.wasm" {
                in_place true
                kiosk true
              };
              SwitchToMode "Normal"
            }
          }
        }
      '';

      "zellij/layouts/dash.kdl".text = ''
        layout {
          default_tab_template {
            children

            pane size=1 borderless=true {
                plugin location="https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm" {
                format_left   "{mode} #[fg=#89B4FA,bold]{session}"
                format_center "{tabs}"
                format_right  "{command_git_branch} {datetime}"
                format_space  ""

                border_enabled  "false"
                border_char     "─"
                border_format   "#[fg=#6C7086]{char}"
                border_position "top"

                hide_frame_for_single_pane "true"

                mode_normal  "#[bg=blue] "
                mode_tmux    "#[bg=#ffc387] "

                tab_normal   "#[fg=#6C7086] {name} "
                tab_active   "#[fg=#9399B2,bold,italic] {name} "

                // command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                // command_git_branch_format      "#[fg=blue] {stdout} "
                // command_git_branch_interval    "10"
                // command_git_branch_rendermode  "static"

                datetime        "#[fg=#6C7086,bold] {format} "
                datetime_format "%A, %d %b %Y %H:%M"
                datetime_timezone "Europe/Warsaw"
              }
            }
          }

          tab name="DashBoard" focus=true {

            pane split_direction="vertical" {
              pane size=60 {
                pane size=15{
                  command "/home/levizor/.cargo/bin/tclock"
                }
                pane focus=true {
                  plugin location="zellij:strider"
                }
              }
              pane {
                command "btop"
              }
            }
          }

          tab name="Edit" {
            pane {
              plugin location="https://github.com/imsnif/monocle/releases/latest/download/monocle.wasm"{
                in_place true
                kiosk true
              }
            }
          }
          tab name="Whatever"
        }

      '';

      "zellij/layouts/default.kdl".text = ''
          layout {
          default_tab_template {
            children

            pane size=1 borderless=true {
                plugin location="https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm" {
                format_left   "{mode} #[fg=#89B4FA,bold]{session}"
                format_center "{tabs}"
                format_right  "{command_git_branch} {datetime}"
                format_space  ""

                border_enabled  "false"
                border_char     "─"
                border_format   "#[fg=#6C7086]{char}"
                border_position "top"

                hide_frame_for_single_pane "true"

                mode_normal  "#[bg=blue] "
                mode_tmux    "#[bg=#ffc387] "

                tab_normal   "#[fg=#6C7086] {name} "
                tab_active   "#[fg=#9399B2,bold,italic] {name} "

                command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                command_git_branch_format      "#[fg=blue] {stdout} "
                command_git_branch_interval    "10"
                command_git_branch_rendermode  "static"

                datetime        "#[fg=#6C7086,bold] {format} "
                datetime_format "%A, %d %b %Y %H:%M"
                datetime_timezone "Europe/Berlin"
              }
            }
          }
        }

      '';
    };
  };
}

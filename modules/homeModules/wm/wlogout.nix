{
  flake.homeModules.wlogout =
    { pkgs, ... }:
    {
      programs.wlogout = {
        enable = true;
        layout = [
          {
            label = "lock";
            action = "hyprlock";
            text = "Lock";
            keybind = "l";
          }
          {
            label = "hibernate";
            action = "systemctl hibernate";
            text = "Hibernate";
            keybind = "h";
          }
          {
            label = "logout";
            action = "loginctl terminate-user $USER";
            text = "Logout";
            keybind = "e";
          }
          {
            label = "shutdown";
            action = "systemctl poweroff";
            text = "Shutdown";
            keybind = "s";
          }
          {
            label = "suspend";
            action = "systemctl suspend";
            text = "Suspend";
            keybind = "u";
          }
          {
            label = "reboot";
            action = "systemctl reboot";
            text = "Reboot";
            keybind = "r";
          }
        ];
        style =
          let
            wlogoutIcons = {
              lock = "${pkgs.wlogout}/share/wlogout/icons/lock.png";
              logout = "${pkgs.wlogout}/share/wlogout/icons/logout.png";
              suspend = "${pkgs.wlogout}/share/wlogout/icons/suspend.png";
              hibernate = "${pkgs.wlogout}/share/wlogout/icons/hibernate.png";
              shutdown = "${pkgs.wlogout}/share/wlogout/icons/shutdown.png";
              reboot = "${pkgs.wlogout}/share/wlogout/icons/reboot.png";
            };
          in
          ''
            * {
            	background-image: none;
            	box-shadow: none;
            }

            window {
            	background-color: rgba(10, 10, 25, 0.92);
            	padding: 20px;
            }

            /* Add spacing between buttons */
            button {
            	margin: 10px;
            	padding: 20px;
            	border-radius: 12px;
            	border-color: #6C6CE5;
            	text-decoration-color: #E0F7FA;
            	color: #E0F7FA;
            	background-color: transparent;
            	border-style: solid;
            	border-width: 2px;
            	background-repeat: no-repeat;
            	background-position: center;
            	background-size: 25%;
            	transition: all 0.2s ease-in-out;
            }

            /* Hover/active/focus effect with glow */
            button:focus,
            button:active,
            button:hover {
            	background-color: rgba(47, 25, 95, 0.3); /* Slight tint on hover */
            	outline-style: none;
            	box-shadow: 0 0 10px #8BE9FD, 0 0 20px #6C6CE5;
            }

            /* Button icons */
            #lock {
            	background-image: image(url("${wlogoutIcons.lock}"));
            }

            #logout {
            	background-image: image(url("${wlogoutIcons.logout}"));
            }

            #suspend {
            	background-image: image(url("${wlogoutIcons.suspend}"));
            }

            #hibernate {
            	background-image: image(url("${wlogoutIcons.hibernate}"));
            }

            #shutdown {
            	background-image: image(url("${wlogoutIcons.shutdown}"));
            }

            #reboot {
            	background-image: image(url("${wlogoutIcons.reboot}"));
            }
          '';
      };
    };
}

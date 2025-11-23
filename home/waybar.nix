{...}: {
  programs.waybar = {
    enable = true;

    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 30;

        modules-left = [
          "custom/logo"
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "cpu"
          "bluetooth"
          "tray"
          "memory"
          "network"
          "wireplumber"
          "battery"
          "custom/power"
        ];

        # --- Modules Configuration ---

        "custom/logo" = {
          format = "󱄅";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            default = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            active = "󱓻";
            urgent = "󱓻";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        clock = {
          tooltip = false;
          format = "  {:L%H:%M}";
          format-alt = "󰃭  {:L%a %d %b %Y}";
        };

        cpu = {
          interval = 5;
          format = "  {}%";
          max-length = 10;
          on-click = "ghostty -e btop";
        };

        memory = {
          interval = 5;
          format = "  {}%";
          max-length = 10;
          on-click = "ghostty -e btop";
        };

        bluetooth = {
          controller = "MX Keys Mini";
          format-on = "󰂯";
          format-off = "󰂲";
          format-disabled = "";
          format-connected = "󰂱 {num_connections}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t󰥁 {device_battery_percentage}%";
          on-click = "ghostty -e bluetui";
        };

        tray = {
          spacing = 10;
        };

        network = {
          format-wifi = "{icon}";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format-ethernet = "󰀂";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{icon} {essid}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "󰀂  {ifname}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          interval = 5;
          on-click = "ghostty -e nmtui";
        };

        wireplumber = {
          format = "{icon}";
          format-bluetooth = "󰂰";
          tooltip-format = "Volume : {volume}%";
          format-muted = "󰝟";
          format-icons = {
            headphone = "";
            default = ["󰖀" "󰕾" ""];
          };
          scroll-step = 10;
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = {
            charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
            default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          format-full = "Charged ";
          interval = 5;
          states = {
            warning = 30;
            critical = 15;
          };
          tooltip = false;
        };

        "custom/power" = {
          format = "󰤆";
          tooltip = false;
          #on-click = "~/.config/rofi/powermenu/type-2/powermenu.sh &";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: JetBrainsMono Nerd Font;
        font-size: 13px;
      }

      window#waybar {
        background-color: #181825;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      window#waybar.hidden {
        opacity: 0.5;
      }

      #workspaces {
        background-color: transparent;
      }

      #workspaces button {
        all: initial;
        /* Remove GTK theme values (waybar #1351) */
        min-width: 0;
        /* Fix weird spacing in materia (waybar #450) */
        box-shadow: inset 0 -3px transparent;
        /* Use box-shadow instead of border so the text isn't offset */
        padding: 1px 12px;
        margin: 4px 3px;
        border-radius: 2px;
        background-color: #1e1e2e;
        color: #cdd6f4;
      }

      #workspaces button.active {
        color: #1e1e2e;
        background-color: #cdd6f4;
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        color: #1e1e2e;
        background-color: #cdd6f4;
      }

      #workspaces button.urgent {
        background-color: #f38ba8;
      }

      #memory,
      #custom-power,
      #battery,
      #cpu,
      #backlight,
      #wireplumber,
      #network,
      #bluetooth,
      #clock,
      #tray {
        border-radius: 4px;
        margin: 4px 3px;
        padding: 1px 12px;
        background-color: #1e1e2e;
        color: #181825;
      }

      #custom-power {
        margin-right: 6px;
      }

      #custom-logo {
        padding-right: 12px;
        padding-left: 7px;
        margin-left: 5px;
        font-size: 20px;
        border-radius: 8px 0px 0px 8px;
        color: #1793d1;
      }

      #memory {
        background-color: #fab387;
      }

      #battery {
        background-color: #f38ba8;
      }

      #battery.warning,
      #battery.critical,
      #battery.urgent {
        background-color: #ff0000;
        color: #FFFF00;
      }

      #battery.charging {
        background-color: #a6e3a1;
        color: #181825;
      }

      #backlight {
        background-color: #fab387;
      }

      #wireplumber {
        background-color: #f9e2af;
      }

      #network {
        background-color: #94e2d5;
        padding-right: 17px;
      }

      #cpu {
        background-color: #94e2d5;
      }

      #bluetooth {
        background-color: #94e2d5;
      }

      #clock {
        font-family: JetBrainsMono Nerd Font;
        background-color: #cba6f7;
      }

      #custom-power {
        background-color: #f2cdcd;
      }

      tooltip {
        border-radius: 8px;
        padding: 15px;
        background-color: #131822;
      }

      tooltip label {
        padding: 5px;
        background-color: #131822;
      }
    '';
  };
}

{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["hyprland/language" "custom/weather" "network" "pulseaudio" "battery" "clock" "tray"];
        "hyprland/workspaces" = {
          disable-scroll = true;
          show-special = true;
          special-visible-only = true;
          all-outputs = false;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
            "10" = "";
            "magic" = "";
          };

          persistent-workspaces = {
            "*" = 10;
          };
        };

        "hyprland/language" = {
          format-en = "🇺🇸";
          format-ara = "🇲🇦";
          min-length = 5;
          tooltip = true;
          on-click = "hyprctl devices -j | jq -r '.keyboards[].name' | while read -r dev; do hyprctl switchxkblayout \"$dev\" next; done";
        };

        "custom/weather" = {
          format = "{}";
          exec = pkgs.writeScript "weather.sh" ''
            #!/bin/sh
            weather=$(curl -s 'wttr.in/Casablanca?format=%c%t')
            echo "{\"text\":\" $weather \",\"tooltip\":\"Casablanca, Morocco\"}"
          '';
          return-type = "json";
          interval = 300;
          class = "weather";
        };

        "network" = {
          format-wifi = " {signalStrength}%";
          format-ethernet = " {ipaddr}/{cidr}";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{ifname} via {gwaddr} ";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          on-click = "nm-connection-editor";
          interval = 2;
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% ";
          format-muted = "";
          format-icons = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" ""];
          };
          on-click = "pavucontrol";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 1;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-full = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
          tooltip-format-charging = "⚡ Charging ({capacity}%)\nRemaining: {time}";
          tooltip-format-discharging = "🔋 Discharging ({capacity}%)\nRemaining: {time}";
          tooltip-format-plugged = "🔌 Plugged In ({capacity}%)";
          tooltip-format-full = "🔌 Fully Charged & Plugged In ({capacity}%)";
        };

        "clock" = {
          format = "{:%d.%m.%Y - %H:%M}";
          format-alt = "{:%A, %B %d at %R}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "tray" = {
          icon-size = 14;
          spacing = 12;
        };
      };
    };
  };
}

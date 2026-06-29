{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    systemd.enable = true;
    settings = {
      env = [
        # Hint Electron apps to use Wayland
        "NIXOS_OZONE_WL,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,$HOME/screens"
      ];

      monitor = ",1920x1080@60,auto,1";
      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";
      "$fileManager" = "$terminal -e yazi";
      "$menu" = "wofi";

      exec-once = [
        "waybar"
        "nm-applet --indicator"
        "systemctl --user start hyprpolkitagent"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;

        border_size = 5;

        "col.active_border" = "rgba(d65d0eff) rgba(98971aff) 45deg";
        "col.inactive_border" = "rgba(3c3836ff)";

        resize_on_border = true;

        allow_tearing = false;
        layout = "master";
      };

      decoration = {
        rounding = 0;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = false;
        };

        blur = {
          enabled = false;
        };
      };

      animations = {
        enabled = false;
      };

      input = {
        kb_layout = "us,ara";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        touchpad = {
          natural_scroll = true;
        };
      };

      gesture = [
        "3, horizontal, workspace"
      ];

      dwindle = {
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        new_on_top = true;
        mfact = 0.5;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      windowrule = [
        "float on, match:class .*mpv.*"
        "float on, match:class .*imv.*"
        "float on, match:class .*showmethekey-gtk.*"
        "move 990 60, match:class .*showmethekey-gtk.*"
        "size 900 170, match:class .*showmethekey-gtk.*"
        "pin on, match:class .*showmethekey-gtk.*"
        "no_initial_focus on, match:class .*showmethekey-gtk.*"
        "noborder on, match:class .*showmethekey-gtk.*"
        "no_focus on, match:class .*showmethekey-gtk.*"

        "workspace 3, match:class .*obsidian.*"
        "workspace 3, match:class .*zathura.*"
        "workspace 4, match:class .*com.obsproject.Studio.*"
        "workspace 5, match:class .*telegram.*"
        "workspace 5, match:class .*vesktop.*"
        "workspace 6, match:class .*teams-for-linux.*"

        "suppress_event maximize, match:class .*"
        "no_focus on, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 1"
      ];

      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
    };
  };
}

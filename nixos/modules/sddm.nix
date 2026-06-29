{ pkgs, lib, inputs, ... }:
let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };

  # 1. Option 2: Firewatch Cliff Sunset
  wp-cliff = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/DenverCoder1/minimalistic-wallpaper-collection/main/images/olly-moss-dadaws-firewatch-cliff.jpg";
    sha256 = "99ee2e51f636c38e2c5500b3c71f80e0b4bdd879427faef850d5a0386ca7416d";
  };

  # 2. Option 3: Bright Moon Forest
  wp-moon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/DenverCoder1/minimalistic-wallpaper-collection/main/images/olly-moss-dadaws-firewatch-bright-moon.jpg";
    sha256 = "98408ff881269ec1a7c2432d797f5147921a1bda820d1866300d122dea588181";
  };

  # 3. Option 5: Green Forest Horizon
  wp-green = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/DenverCoder1/minimalistic-wallpaper-collection/main/images/olly-moss-firewatch-green.png";
    sha256 = "6078d1d603321f39b445fea66bc7eddc57cee27c145873ce3b0c89e923f57ba8";
  };

  sddm-astronaut-theme = pkgs.stdenvNoCC.mkDerivation {
    name = "sddm-astronaut-theme";
    src = unstable-pkgs.sddm-astronaut.src;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes/sddm-astronaut
      cp -r * $out/share/sddm/themes/sddm-astronaut/
      sed -i 's|^[[:space:]]*Background[[:space:]]*=[[:space:]]*.*|Background="/var/lib/sddm/custom-wallpaper.png"|g' $out/share/sddm/themes/sddm-astronaut/Themes/astronaut.conf
    '';
  };
in {
  # Enable proper input device driver configuration
  services.libinput.enable = true;

  # Enable Wayland-native SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut";
    extraPackages = [
      sddm-astronaut-theme
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtmultimedia
      pkgs.kdePackages.qtvirtualkeyboard
    ];
  };

  # Link the theme globally so SDDM can find it at /run/current-system/sw/share/sddm/themes/
  environment.systemPackages = [
    sddm-astronaut-theme
  ];

  # Disable TTY autologin to let the graphical login manager take priority
  services.getty.autologinUser = lib.mkForce null;

  # Systemd service to choose a random wallpaper on boot and copy it
  # to the mutable display manager directory.
  systemd.services.sddm-wallpaper-rotator = {
    description = "Select a random wallpaper for SDDM on boot";
    before = [ "display-manager.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "rotate-sddm-wp" ''
        wallpapers=(
          "${wp-cliff}"
          "${wp-moon}"
          "${wp-green}"
        )
        random_wp=''${wallpapers[$RANDOM % ''${#wallpapers[@]}]}
        mkdir -p /var/lib/sddm
        chown sddm:sddm /var/lib/sddm
        cp "$random_wp" /var/lib/sddm/custom-wallpaper.png
        chmod 644 /var/lib/sddm/custom-wallpaper.png
        chown sddm:sddm /var/lib/sddm/custom-wallpaper.png
      '';
    };
  };
}

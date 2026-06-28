{ pkgs, lib, inputs, ... }:
let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };

  sddm-astronaut-theme = pkgs.stdenvNoCC.mkDerivation {
    name = "sddm-astronaut-theme";
    src = unstable-pkgs.sddm-astronaut.src;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes/sddm-astronaut
      cp -r * $out/share/sddm/themes/sddm-astronaut/
      cp $out/share/sddm/themes/sddm-astronaut/Themes/japanese_aesthetic.conf $out/share/sddm/themes/sddm-astronaut/Themes/astronaut.conf
    '';
  };
in {
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
}

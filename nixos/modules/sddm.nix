{ pkgs, lib, inputs, ... }:
let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  # Enable Wayland-native SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = unstable-pkgs.kdePackages.sddm;
    theme = "sddm-astronaut";
    extraPackages = [
      unstable-pkgs.sddm-astronaut
      unstable-pkgs.kdePackages.qtsvg
    ];
  };

  # Disable TTY autologin to let the graphical login manager take priority
  services.getty.autologinUser = lib.mkForce null;
}

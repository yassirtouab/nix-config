{ pkgs, lib, ... }: {
  # Enable Wayland-native SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [
      pkgs.sddm-astronaut
    ];
  };

  # Disable TTY autologin to let the graphical login manager take priority
  services.getty.autologinUser = lib.mkForce null;
}

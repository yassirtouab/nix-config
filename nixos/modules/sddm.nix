{ lib, ... }: {
  # Enable Wayland-native SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Disable TTY autologin to let the graphical login manager take priority
  services.getty.autologinUser = lib.mkForce null;
}

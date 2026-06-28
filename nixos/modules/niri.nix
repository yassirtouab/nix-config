{ pkgs, ... }: {
  # Enable Niri Wayland compositor system-wide
  programs.niri.enable = true;

  # Enable Noctalia system module globally
  programs.noctalia.enable = true;

  # Core hardware daemon telemetry for Noctalia's widgets
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  security.rtkit.enable = true; # Prevents PipeWire audio stuttering

  # XDG portals configuration for Niri session
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}

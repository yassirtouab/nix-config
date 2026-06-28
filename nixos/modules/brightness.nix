{ pkgs, ... }: {
  # Enable global keyboard daemon for system-level hotkeys (e.g. display brightness)
  # This makes F3/F4 screen brightness keys work on the login screen, console, and desktop.
  services.actkbd = {
    enable = true;
    bindings = [
      {
        keys = [ 224 ]; # Screen Brightness Down keycode
        events = [ "key" "rep" ];
        command = "${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
      }
      {
        keys = [ 225 ]; # Screen Brightness Up keycode
        events = [ "key" "rep" ];
        command = "${pkgs.brightnessctl}/bin/brightnessctl set 10%+";
      }
    ];
  };

  # Declaratively force the actkbd instance for your built-in keyboard (event1)
  # to start automatically on system boot.
  systemd.services."actkbd@event1" = {
    wantedBy = [ "multi-user.target" ];
  };
}

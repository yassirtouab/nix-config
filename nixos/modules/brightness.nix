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
}

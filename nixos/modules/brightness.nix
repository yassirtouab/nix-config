{ pkgs, ... }: {
  # Enable the global keyboard daemon
  services.actkbd = {
    enable = true;
    bindings = [
      {
        keys = [ 224 ]; # Screen Brightness Down
        events = [ "key" "rep" ];
        command = "${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
      }
      {
        keys = [ 225 ]; # Screen Brightness Up
        events = [ "key" "rep" ];
        command = "${pkgs.brightnessctl}/bin/brightnessctl set 10%+";
      }
    ];
  };

  # Broaden the udev rule to launch actkbd on all event input devices,
  # ensuring virtual ACPI and HP WMI hotkey buses are captured.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="input", KERNEL=="event*", TAG+="systemd", ENV{SYSTEMD_WANTS}+="actkbd@%k.service"
  '';
}

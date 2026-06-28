{ pkgs, ... }: {
  # Write the actkbd configuration file directly to /etc/actkbd.conf
  environment.etc."actkbd.conf".text = ''
    224:key+rep:exec:${pkgs.brightnessctl}/bin/brightnessctl set 10%-
    225:key+rep:exec:${pkgs.brightnessctl}/bin/brightnessctl set 10%+
  '';

  # Define a dedicated, non-templated systemd service that binds directly to your keyboard (event1)
  systemd.services.actkbd-brightness = {
    description = "Active Keyboard Daemon for Brightness Keys";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-udev-settle.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.actkbd}/bin/actkbd -d /dev/input/event1 -c /etc/actkbd.conf";
      Restart = "always";
      RestartSec = "5s";
    };
  };
}

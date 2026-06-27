{ pkgs, ... }: {
  # Enable the Linux IR Emitter service for the IR camera
  services.linux-enable-ir-emitter.enable = true;

  # Enable the Howdy facial authentication service
  services.howdy = {
    enable = true;
    settings = {
      core = {
        device_path = "/dev/video0";
        max_frame_width = 320;
        certainty = 3.5;
      };
    };
  };

  # Enable PAM configuration for Howdy
  security.pam.services = {
    sudo.howdy.enable = true;
    login.howdy.enable = true;
  };
}

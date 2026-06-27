{ inputs, ... }: {
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;

    # Explicitly configure the official Flathub repository
    remotes = [
      { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
    ];

    # Declare your list of Flatpaks
    packages = [
      "org.signal.Signal"
    ];

    # Strictly declarative: removes any Flatpak not declared in this list
    uninstallUnmanaged = true;

    # Keep your Flatpaks updated automatically in the background
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}

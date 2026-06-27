{ pkgs, stateVersion, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
    ../../nixos/modules/sddm.nix
  ];

  # Enable support for proprietary/unfree packages (like Anytype or Obsidian)
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [ pkgs.home-manager ];

  networking.hostName = hostname;

  system.stateVersion = stateVersion;
}

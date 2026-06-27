# HP EliteBook 855 G8 hardware-configuration.nix Placeholder
#
# INSTRUCTIONS:
# 1. Boot your live USB installer on the HP EliteBook 855 G8.
# 2. Run `nixos-generate-config` to generate your hardware configuration.
# 3. Paste the contents of `/etc/nixos/hardware-configuration.nix` here.
# 4. IMPORTANT: Since disk partitioning and filesystems are declared declaratively
#    in `disko.nix`, you MUST delete the auto-generated `fileSystems` and `swapDevices`
#    blocks from the pasted configuration to avoid conflicts.
#
# Below is a minimal valid placeholder to ensure evaluation succeeds for now.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # Note: fileSystems and swapDevices are fully managed by disko.nix.
  # Do not add them here to prevent evaluation conflicts.

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

# ⚠️ Duplicate FileSystem & Swap Conflict Prevention

## The Conflict
When you first boot your fresh NixOS system after installing from the Live USB, the installer generates a static `/etc/nixos/hardware-configuration.nix` file mapping all active filesystems and swap partitions.

If you then attempt to run `nixos-rebuild switch --flake .#elitebook` using your custom configurations, NixOS will try to evaluate **both**:
1. `hosts/elitebook/disko.nix` (which dynamically configures filesystems and mounts)
2. `hosts/elitebook/hardware-configuration.nix` (which contains the static generated mounts)

This will cause a build error: **`conflicting definition values`** for `/`, `/home`, `/nix`, `/var/log`, and swap space.

## The Resolution
During or immediately after your installation, when copying your generated hardware configuration to the flake folder, you must edit `hosts/elitebook/hardware-configuration.nix` to delete or comment out the entire `fileSystems` and `swapDevices` blocks.

### Step-by-Step Instructions:

1. **Wait for the installation to finish and boot into your new NixOS environment.**
2. **Open the hardware configuration in your favorite editor:**
   ```bash
   nano hosts/elitebook/hardware-configuration.nix
   ```
3. **Locate the auto-generated `fileSystems` and `swapDevices` blocks.** They will look similar to this:
   ```nix
   fileSystems."/" =
     { device = "/dev/disk/by-uuid/...";
       fsType = "btrfs";
       options = [ "subvol=@" "compress=zstd" "noatime" ];
     };

   fileSystems."/home" =
     { device = "/dev/disk/by-uuid/...";
       fsType = "btrfs";
       options = [ "subvol=@home" "compress=zstd" "noatime" ];
     };

   # ... other fileSystems entries ...

   swapDevices = [ { device = "/dev/disk/by-uuid/..."; } ];
   ```
4. **Delete these blocks entirely** (or comment them out by prefixing the lines with `#`).
5. **Save the file.**
6. **Commit the changes to git** (Nix flakes require changes to be staged/committed to recognize them):
   ```bash
   git add hosts/elitebook/hardware-configuration.nix
   ```
7. **Switch and rebuild your system configuration cleanly:**
   ```bash
   nh os switch
   # Or: sudo nixos-rebuild switch --flake .#elitebook
   ```

By removing these static blocks, you cleanly delegate all mount-point and swap management directly to Disko.

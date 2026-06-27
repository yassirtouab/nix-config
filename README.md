# ❄️ NixOS Config Reborn

Welcome to my redesigned NixOS configuration built for efficiency and aesthetics. 

## ✨ Features

- 🖥️ **Multiple Hosts Support**: Easy to configure for different hosts.
- 🎨 **Gruvbox Theme**: A perfect blend of vibrant and subtle colors.
- 🪟 **Hyprland + Waybar**: 10/10 window compositor on Wayland.
- 🏠 **Home Manager Integration**: lots of stuff configured.
- 🧇 **Tmux**: with my own hotkeys.
- 🌟 **Zsh + starship**: Efficient shell setup with lots of aliases.

## 🚀 Installation

To boot-strap your fresh NixOS system directly from the Live USB installer:

### 🌐 Phase 1: Environment & Network Setup
1. **Boot the NixOS Live USB** on your target machine.
2. **Open a terminal** and switch to root:
   ```bash
   sudo -i
   ```
3. **Connect to the internet** (use `nmtui` for Wi-Fi if needed):
   ```bash
   nmtui
   ```
   *(Verify your connection by running `ping -c 3 nixos.org`).*

### 💾 Phase 2: Disk Partitioning & Formatting (Disko)
4. **Clone this repository** on the Live USB environment:
   ```bash
   git clone https://github.com/Andrey0189/nixos-config-reborn
   cd nixos-config-reborn
   ```
5. **Run the Disko partitioning utility** to format your disk and mount the EFI boot partition, filesystems, and swap space automatically under `/mnt`:
   ```bash
   nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./hosts/<hostname>/disko.nix
   ```
   *(Replace `<hostname>` with your target host name, e.g. `elitebook`. Verify active mounts with `lsblk` or `df -h`).*

### ⚙️ Phase 3: Hardware Profile Integration
6. **Generate your hardware profile** using the `--no-filesystems` flag (this prevents NixOS from writing conflicting partition-mount entries, letting Disko manage them cleanly):
   ```bash
   nixos-generate-config --no-filesystems --root /mnt
   ```
7. **Copy the generated configuration** into your local flake folder:
   ```bash
   cp /mnt/etc/nixos/hardware-configuration.nix ./hosts/<hostname>/
   ```
8. **Double-check the file** to ensure there are no auto-generated `fileSystems` or `swapDevices` blocks that might conflict with Disko:
   ```bash
   cat ./hosts/<hostname>/hardware-configuration.nix
   ```
   *(If you ran `nixos-generate-config` without the `--no-filesystems` flag, make sure you manually delete any `fileSystems` and `swapDevices` blocks from that file to prevent configuration conflicts).*

### 🚀 Phase 4: Stage & Install
9. **Stage all files in Git** so that Nix Flakes can read them (otherwise Nix will ignore new files):
   ```bash
   git add .
   ```
10. **Run the installation command** targeting your mounted disk:
    ```bash
    nixos-install --flake .#<hostname>
    ```
    *(During this process, Nix will automatically generate a fresh `flake.lock` and prompt you to set your root password).*
11. **Reboot the system**:
    ```bash
    reboot
    ```

---

For subsequent post-install modifications, navigate to your flake repository and rebuild via:
```bash
nh os switch --update
```


## 🤝 Contributions

Feel free to fork the repository and submit pull requests if you'd like to contribute improvements. Open issues if you encounter any problems with the config or have ideas for new features.


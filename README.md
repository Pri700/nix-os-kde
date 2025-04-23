# 💻 My NixOS KDE Configuration

Welcome to my personal NixOS configuration with the KDE Plasma desktop environment. This setup is crafted for stability, performance, and full declarative control via `configuration.nix`.

> ⚡ Powered by NixOS — the purely functional Linux distribution.

---

## 📸 Screenshots

- 🖥️ Desktop Overview
- ![1745393493549](https://github.com/user-attachments/assets/9bfb963a-a0ac-4f28-bef1-1be6de0fcd47)

- 🎨 Theming and Look-and-Feel
- ![1745393493533](https://github.com/user-attachments/assets/ef38fd34-5b97-427c-a264-4375b15d944a)
- ![image](https://github.com/user-attachments/assets/07e22e65-03d3-4649-b4dc-32d0f920a990)


- ⚙️ System Settings

---

## 🧠 Understanding `configuration.nix`

`/etc/nixos/configuration.nix` is the heart of a NixOS system. It defines everything — installed packages, services, user accounts, desktop environment, and system-wide settings.

Here’s a high-level breakdown:

```nix
{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix  # Auto-generated hardware config
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "your-hostname";  # Set your system's hostname
  time.timeZone = "Region/City";          # Timezone config

  # User account setup
  users.users.yourusername = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # sudo + networking access
    packages = with pkgs; [
      firefox
      vscode
      # add your user-specific packages here
    ];
  };

  # KDE Plasma setup
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.displayManager.sddm.enable = true;

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    # add more system-wide packages here
  ];

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable OpenSSH if needed
  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Match this to your installed NixOS version
}

# nix-os-kde
NixOS config repo with a custom KDE Plasma desktop. Declarative, lightweight setup with curated themes, widgets, and optimized settings for productivity &amp; style. Ideal for devs &amp; enthusiasts exploring NixOS + KDE. Fork it!

NixOS + KDE Setup Guide for Beginners
This repository provides a NixOS configuration with a customized KDE Plasma desktop. Follow these steps to set up NixOS with KDE on your system. This guide assumes you're new to Linux and NixOS.
Prerequisites

A computer with at least 4GB RAM and 20GB free disk space.
A USB drive (4GB+).
Basic familiarity with a terminal.

Step 1: Download NixOS

Visit NixOS Downloads.
Download the "Graphical ISO image" (e.g., nixos-24.05.x86_64-linux.iso).
Verify the download:sha256sum nixos-24.05.x86_64-linux.iso

Compare the output with the checksum on the website.

Step 2: Create a Bootable USB

Install a tool like Balena Etcher.
Insert your USB drive.
Use Etcher to flash the NixOS ISO onto the USB.

Step 3: Boot into NixOS Live Environment

Restart your computer and enter the BIOS/UEFI (usually by pressing F2, F12, or Del).
Set the USB as the first boot device.
Save and reboot.
Select the NixOS live image from the boot menu.

Step 4: Install NixOS

In the live environment, open a terminal.
Partition your disk (replace /dev/sda with your disk):sudo parted /dev/sda
(parted) mklabel gpt
(parted) mkpart primary 1MiB 512MiB
(parted) mkpart primary 512MiB 100%
(parted) set 1 boot on
(parted) quit


Format partitions:sudo mkfs.fat -F 32 /dev/sda1
sudo mkfs.ext4 /dev/sda2


Mount partitions:sudo mount /dev/sda2 /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/sda1 /mnt/boot


Generate NixOS configuration:sudo nixos-generate-config --root /mnt


Edit the configuration file:sudo nano /mnt/etc/nixos/configuration.nix


Add KDE Plasma to the configuration. Replace the services.xserver section with:services.xserver.enable = true;
services.xserver.displayManager.sddm.enable = true;
services.xserver.desktopManager.plasma5.enable = true;


Save (Ctrl+O, Enter, Ctrl+X).
Install NixOS:sudo nixos-install


Set a root password when prompted:passwd


Reboot:reboot



Step 5: Clone and Apply This Repository

Log in as root.
Install git:nix-shell -p git


Clone this repository:git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git /etc/nixos/kde-config

Replace YOUR_USERNAME and YOUR_REPOSITORY with your GitHub details.
Copy the configuration:sudo cp /etc/nixos/kde-config/configuration.nix /etc/nixos/configuration.nix


Apply the configuration:sudo nixos-rebuild switch



Step 6: Log In to KDE

Reboot:reboot


Log in to the KDE Plasma desktop.
Customize KDE via System Settings (e.g., themes, widgets).

Understanding NixOS and KDE

NixOS: A Linux distribution using a declarative configuration file (/etc/nixos/configuration.nix) to define system settings, packages, and services. Changes are applied with nixos-rebuild switch.
KDE Plasma: A graphical desktop environment known for its flexibility and modern look. This repo customizes Plasma with themes and widgets.
This Repo: Provides a pre-configured configuration.nix with KDE Plasma, optimized settings, and customizations.

Troubleshooting

No GUI? Ensure services.xserver settings are correct in configuration.nix.
Clone failed? Check your internet connection and GitHub URL.
Need help? Open an issue on this repository or check NixOS Manual.

Next Steps

Explore /etc/nixos/configuration.nix to add packages or tweak settings.
Learn more about Nix at NixOS Wiki.
Customize KDE via System Settings > Appearance.

Happy hacking with NixOS and KDE!


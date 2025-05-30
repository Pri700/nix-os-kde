# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
 boot.kernelPackages = pkgs.linuxPackages_latest;
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth.enable = true; # for plymouth logo


  programs.kdeconnect.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.sssd.kcm = true;
  #services.displayManager.sddm.theme = "sddm-suger-dark";

  nix.settings.experimental-features = ["nix-command" "flakes"];
 # nix.settings.experimental-features = nix-command flakes;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pritam = {
    isNormalUser = true;
    description = "Pritam";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # font
  fonts.fontDir.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    micro
    vivaldi
   # protonmail-bridge
    #protonmail-bridge-gui
    telegram-desktop
    signal-desktop
    freetube
    git
    rustc
    rustup-toolchain-install-master
    rustus
    cargo
    rustfmt
    clippy
    ruby
    bundler
    rustup
    wineWowPackages.stable
    winetricks
    blender
   # krita
    shotcut
    obs-studio
    vlc
   spotify
   # amberol
    gimp
   # libtiff-4.0.3-opentoon
    synfigstudio
    glava
    cava
    #rhythmbox
    #opentoonz

    # Utilities
    weston
    wget
    hblock
    parabolic
    heimdall
    ventoy-full
    pkgs.android-tools
    adb-sync
    wpsoffice
    hyfetch
    neofetch
    anydesk
    klavaro
    tuxtype
    appimage-run
    htop
    fish
    gparted
    arch-install-scripts
    podman

    #KDE
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.partitionmanager
    haruna
    sddm-sugar-dark
    #ibsForQt5.sddm-kcm
    kdePackages.sddm-kcm
    #kdePackages.kamoso

    # Font all
    noto-fonts # Broad Unicode coverage for many languages
        #noto-fonts-cjk # Chinese, Japanese, Korean
       
  ];


  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  #virtualisation.waydroid.enable = true;

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}

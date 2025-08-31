
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, outputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      inputs.home-manager.nixosModules.home-manager
    ];

  boot.kernel.sysctl."vm.max_map_count" = 2147483642;

   home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      lucas = import ../../home-manager/home.nix;
    };
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Enable the KDE Plasma Desktop Environment.

  services = {
    displayManager = {
      sddm.enable = true;
      defaultSession = "cosmic";
    };
    desktopManager.plasma6.enable = true;
    desktopManager.cosmic.enable = true;
    fprintd.enable = true;
    locate.enable = true;
    xserver.enable = true;
    preload.enable = true;
  };



  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.pam.services.sddm.enableKwallet = true;
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


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lucas = {
    isNormalUser = true;
    description = "lucas";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "lucas";

  # Install firefox.
  programs = {
    firefox.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };
    gamemode.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # add user's shell into /etc/shells
  environment.shells = [
    pkgs.bashInteractive
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ];

  fonts = {
  enableDefaultPackages = true;
  packages = [ 
    pkgs.nerd-fonts.jetbrains-mono
  ];

  fontconfig = {
    defaultFonts = {
      #serif = [  "Liberation Serif" ];
      #sansSerif = [ "Ubuntu" ];
      monospace = [ "Jetbrains Mono" ];
    };
  };
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

  networking.nameservers = ["1.1.1.1" "1.0.0.1" "9.9.9.9"];

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
}

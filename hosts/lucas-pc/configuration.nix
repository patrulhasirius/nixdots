# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../common
      ./hardware-configuration.nix
    ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
  
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lucas-pc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    piper
    sbctl
  ];

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
  #systemd.services.raid = {
  #  description = "...";
  #  script = ''
  #    #!/usr/bin/env bash

  #    cryptsetup luksOpen /dev/disk/by-uuid/8b0dc62d-4ee6-4713-815a-137c1dbe0729 raid3 --key-file ~/keyfiles/btrfs-8b0d.keyfile
  #    cryptsetup luksOpen /dev/disk/by-uuid/5e8e19cc-3cf6-4eba-8be8-b09ca9c8d494 raid2 --key-file ~/keyfiles/btrfs-5e8e.keyfile
  #    cryptsetup luksOpen /dev/disk/by-uuid/5b0f3855-837b-4653-977d-5254b4d6ce0c raid1 --key-file ~/keyfiles/btrfs-5b0f.keyfile
  #  '';
  #};

  environment.etc.crypttab = {
    mode = "0600";
    text = ''
      # <volume-name> <encrypted-device> [key-file] [options]
      raid1 UUID=5b0f3855-837b-4653-977d-5254b4d6ce0c /root/btrfs-5b0f.keyfile
      raid2 UUID=5e8e19cc-3cf6-4eba-8be8-b09ca9c8d494 /root/btrfs-5e8e.keyfile
      raid3 UUID=8b0dc62d-4ee6-4713-815a-137c1dbe0729 /root/btrfs-8b0d.keyfile
    '';
  };
  environment.variables = {
    #kde wow lag bug https://bugs.kde.org/show_bug.cgi?id=511793
    KWIN_DRM_NO_DIRECT_SCANOUT = 1;
  };
  services = {
    fstrim.enable = true;
    ratbagd.enable = true;
    sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };
    xserver.xkb = {
      layout = "br";
    };
    jackett.enable = true;
    flaresolverr.enable = true;
    displayManager.defaultSession = "plasma";
  };

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
  system.stateVersion = "25.05"; # Did you read the comment?

}

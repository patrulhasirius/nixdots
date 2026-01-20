# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, outputs, config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common
    ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };



  networking.hostName = "lucas-note"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";




  # Configure keymap in X11
  services ={
    xserver.xkb = {
      layout = "br";
      variant = "thinkpad";
    };
    displayManager.defaultSession = "cosmic";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    sbctl
  ];

   # ---------------------------------------------------------------------------
  # Biometric Services Configuration
  # ---------------------------------------------------------------------------

  # 1. Disable the standard fprintd service to prevent conflicts.
  # The open-fprintd module might implicitly conflict with it, but explicit 
  # disabling is safer for declarative configurations.
  services.fprintd.enable = false;

  # 2. Enable the Open-Fprintd Daemon
  # This daemon speaks the D-Bus protocol expected by GNOME/GDM/PAM.
  services.open-fprintd.enable = true;

  # 3. Enable the Python-Validity Driver
  # This service handles the USB communication and firmware upload.
  services.python-validity.enable = true;

  # 4. Service Ordering (Optional but Recommended)
  # Ensure python-validity is up before open-fprintd tries to query it.
  # The module likely handles this, but explicit ordering can fix race conditions.
  systemd.services.open-fprintd.after = [ "python3-validity.service" ];

  # ---------------------------------------------------------------------------
  # Authentication Stack (PAM) Integration
  # ---------------------------------------------------------------------------
  
  # Enabling the service runs the daemon, but doesn't tell the system to USE it 
  # for logging in. We must configure PAM (Pluggable Authentication Modules).
  
  # For unlocking the screen (GDM/KDE/SwayLock)
  security.pam.services.login.fprintAuth = true;
  
  # For sudo access
  security.pam.services.sudo.fprintAuth = true;

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
  system.stateVersion = "25.05"; # Did you read the comment?

}

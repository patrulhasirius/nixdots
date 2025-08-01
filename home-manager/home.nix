# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./kitty.nix
    ./helix.nix
    ./gh.nix
    ./starship.nix
    ./fish.nix
    ./zoxide.nix
    ./obs.nix
    ./fzf.nix
    ./google-drive.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "lucas";
    homeDirectory = "/home/lucas";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git

  programs = {
    home-manager.enable = true;
    git = {
        enable = true;
        userName  = "Lucas Ribeiro";
        userEmail = "patruop@gmail.com";
      };
    neovim.enable = true;
    yazi.enable = true;
  };

  home.packages = [
    pkgs.resources
    pkgs.vscode
    pkgs.gamemode
    pkgs.keepassxc
    pkgs.nil
    pkgs.discord
    pkgs.htop
    pkgs.qdirstat
    pkgs.zoxide
    pkgs.libreoffice-fresh
    pkgs.ffmpeg
    pkgs.zotero
    pkgs.uutils-coreutils-noprefix
    pkgs.ripgrep
    pkgs.fd
    pkgs.bat
    pkgs.eza
    pkgs.gitui
    pkgs.dust
    pkgs.dua
    pkgs.fselect
    pkgs.wiki-tui
  ];
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}

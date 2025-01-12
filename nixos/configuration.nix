{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # General NixOS settings
  nix = {
    channel.enable = false;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };
  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      configurationLimit = 3;
      editor = false;
    };
  };

  # Enable networking
  networking = {
    networkmanager.enable = true;
    wireless.iwd.enable = true;
    hostName = "nixos";
  };

  # Define user
  users.users.igorai = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
  };

  # Set locale
  time.timeZone = "Europe/Oslo";
  console.keyMap = "no";

  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  # XDG portals
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  # Gnome display manager
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  # Gnome keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm-password.enableGnomeKeyring = true;

  # Hyprland
  programs.hyprland.enable = true;

  # Ozone wayland support
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Common packages and binaries
  environment.systemPackages = with pkgs; [
    vim
    wget
    zip
    firefox
  ];

  system.stateVersion = "24.11";
}

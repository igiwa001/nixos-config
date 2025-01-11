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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # Ozone wayland support
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Common packages and binaries
  environment.systemPackages = with pkgs; [
    vim
    wget
    zip
  ];

  system.stateVersion = "24.11";
}

{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./shell.nix
    ./git.nix
    ./hyprland.nix
    ./kitty.nix
  ];

  # Nixpkgs config
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  # Set username
  home = {
    username = "igorai";
    homeDirectory = /home/igorai;
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Reload system units when changing config
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.11";
}

{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/theme.nix
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/neovim/neovim.nix
    ./modules/hyprland/hyprland.nix
    ./modules/applications/kitty.nix
    ./modules/applications/firefox.nix
    ./modules/applications/slack.nix
    ./modules/applications/discord.nix
    ./modules/applications/spotify.nix
    ./modules/applications/libreoffice.nix
    ./modules/applications/mpv.nix
    ./modules/applications/teams.nix
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

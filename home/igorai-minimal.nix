{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/shell/bash.nix
    ./modules/shell/nushell.nix
    ./modules/shell/utils.nix
    ./modules/shell/git.nix
    ./modules/shell/ssh.nix
    ./modules/neovim/neovim.nix
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

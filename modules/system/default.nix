{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.system;
in {
  imports = [
    ./bootloader.nix
    ./nixos.nix
    ./user.nix
    ./networking.nix
    ./locale.nix
    ./bluetooth.nix
    ./pipewire.nix
    ./keyring.nix
    ./fonts.nix
    ./defaults.nix
    ./home-manager.nix
    ./wallpaper.nix
    ./theme.nix
    ./cursor.nix
  ];

  options.settings.system.stateVersion = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
  };

  config = {
    system.stateVersion = lib.mkIf (cfg.stateVersion != null) cfg.stateVersion;

    environment.systemPackages = [
      pkgs.curl
      pkgs.zip
      pkgs.unzip
      pkgs.vim
    ];
  };
}

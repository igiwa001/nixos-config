{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bootloader.nix
    ./nixos.nix
    ./user.nix
    ./networking.nix
    ./locale.nix
    ./bluetooth.nix
    ./pipewire.nix
    ./keyring.nix
  ];

  options.settings.system = {
    stateVersion = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
  };

  config = {
    system.stateVersion = with config.settings.system; lib.mkIf (stateVersion != null) stateVersion;
    home-manager.users.${config.settings.user.username}.home.stateVersion = config.system.stateVersion;

    environment.systemPackages = [
      pkgs.curl
      pkgs.zip
      pkgs.unzip
      pkgs.vim
    ];
  };
}

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
    ./fonts.nix
    ./defaults.nix
    ./home-manager.nix
    ./theme.nix
    ./cursor.nix
  ];

  options.settings.system.stateVersion = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
  };

  config = {
    system.stateVersion = lib.mkIf (cfg.stateVersion != null) cfg.stateVersion;

    settings.home-manager.programs.bash = {
      enable = true;
      initExtra = "[[ -f ~/.profile ]] && . ~/.profile";
    };

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

    programs.dconf.enable = true;

    environment.systemPackages = [
      pkgs.curl
      pkgs.zip
      pkgs.unzip
      pkgs.vim
      pkgs.screen
      pkgs.nix-output-monitor
    ];
  };
}

{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.programs.steam;
in {
  options.settings.programs.steam = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    remotePlay = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    dedicatedServer = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    localNetworkGameTransfers = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    protontricks = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    protonGE = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    mangohud = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config.programs.steam = lib.mkIf cfg.enable {
    enable = true;
    extest.enable = true;

    protontricks.enable = cfg.protontricks;
    remotePlay.openFirewall = cfg.remotePlay;
    dedicatedServer.openFirewall = cfg.dedicatedServer;
    localNetworkGameTransfers.openFirewall = cfg.localNetworkGameTransfers;

    extraCompatPackages = lib.mkIf cfg.protonGE [pkgs.proton-ge-bin];
    package = lib.mkIf cfg.mangohud (pkgs.steam.override {
      extraEnv.MANGOHUD = true;
      extraPkgs = pkgs: [pkgs.mangohud];
    });
  };
}

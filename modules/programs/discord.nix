{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.programs.discord;
in {
  options.settings.programs.discord = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    openASAR = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    vencord = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config.settings.home-manager.home.packages = lib.mkIf cfg.enable [
    (pkgs.discord.override {
      withOpenASAR = cfg.openASAR;
      withVencord = cfg.vencord;
    })
  ];
}

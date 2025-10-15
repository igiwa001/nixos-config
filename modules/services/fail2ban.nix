{
  lib,
  config,
  ...
}: let
  cfg = config.settings.services.fail2ban;
in {
  options.settings.services.fail2ban = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    bantime = lib.mkOption {
      type = lib.types.str;
      default = "10m";
    };

    maxretry = lib.mkOption {
      type = lib.types.ints.unsigned;
      default = 3;
    };

    incremental = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config.services.fail2ban = lib.mkIf cfg.enable {
    enable = true;
    inherit (cfg) bantime maxretry;
    bantime-increment = lib.mkIf cfg.incremental {
      enable = true;
      rndtime = cfg.bantime;
    };
  };
}

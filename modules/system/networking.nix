{
  lib,
  my-lib,
  config,
  ...
}: let
  cfg = config.settings.networking;
in {
  options.settings.networking.hostname = lib.mkOption {
    type = lib.types.nullOr my-lib.types.hostName;
    default = null;
  };

  config = {
    networking = {
      hostName = lib.mkIf (cfg.hostname != null) cfg.hostname;

      wireless.iwd.enable = true;
      networkmanager = {
        enable = true;
        wifi = {
          powersave = false;
          backend = "iwd";
        };
      };
    };
    settings.user.groups = ["networkmanager"];
  };
}

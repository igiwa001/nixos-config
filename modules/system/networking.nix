{
  lib,
  config,
  ...
}: {
  options.settings.networking = {
    hostname = lib.mkOption {
      type = lib.types.nullOr (lib.types.strMatching "^$|^[[:alnum:]]([[:alnum:]_-]{0,61}[[:alnum:]])?$");
      default = null;
    };
  };

  config = {
    settings.user.groups = ["networkmanager"];

    networking = {
      hostName = with config.settings.networking; lib.mkIf (hostname != null) hostname;

      wireless.iwd.enable = true;
      networkmanager = {
        enable = true;
        wifi = {
          powersave = false;
          backend = "iwd";
        };
      };
    };
  };
}

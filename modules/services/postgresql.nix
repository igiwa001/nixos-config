{
  lib,
  config,
  ...
}: let
  cfg = config.settings.services.postgresql;
in {
  options.settings.services.postgresql = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config.services.postgresql = lib.mkIf cfg.enable {
    enable = true;
    ensureUsers = [
      {
        name = config.settings.user.username;
        ensureClauses = {
          superuser = true;
          createrole = true;
          createdb = true;
        };
      }
    ];
  };
}

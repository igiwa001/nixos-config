{
  lib,
  config,
  ...
}: let
  cfg = config.settings.user;
in {
  options.settings.user = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "igorai";
    };

    groups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };

    homeDirectory = lib.mkOption {
      type = lib.types.str;
      default = "/home/${cfg.username}";
    };
  };

  config = {
    users.users.${cfg.username} = {
      isNormalUser = true;
      linger = true;
      initialPassword = "password";
      extraGroups = ["wheel"] ++ cfg.groups;
    };

    settings.home-manager.home = {
      inherit (cfg) username;
      inherit (cfg) homeDirectory;
    };
  };
}

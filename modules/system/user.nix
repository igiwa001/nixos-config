{
  lib,
  config,
  ...
}: {
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
      default = "/home/${config.settings.user.username}";
    };
  };

  config = {
    users.users.${config.settings.user.username} = {
      isNormalUser = true;
      linger = true;
      initialPassword = "password";
      extraGroups = ["wheel"] ++ config.settings.user.groups;
    };

    home-manager.users.${config.settings.user.username}.home = {
      username = config.settings.user.username;
      homeDirectory = config.settings.user.homeDirectory;
    };
  };
}

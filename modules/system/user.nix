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
      default = ["wheel"];
    };
  };

  config.users.users.${config.settings.user.username} = {
    isNormalUser = true;
    linger = true;
    initialPassword = "password";
    extraGroups = config.settings.user.groups;
  };
}

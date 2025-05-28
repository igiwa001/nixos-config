{
  lib,
  config,
  ...
}: {
  options.user = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "igorai";
    };

    groups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["wheel"];
    };
  };

  config.users.users.${config.user.username} = {
    isNormalUser = true;
    linger = true;
    initialPassword = "password";
    extraGroups = config.user.groups;
  };
}

{
  lib,
  my-lib,
  config,
  ...
}: let
  cfg = config.settings;
in {
  options.settings.home-manager = lib.mkOption {
    type = my-lib.types.mergeableAnything;
    default = {};
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users.${cfg.user.username} = cfg.home-manager;
    };

    settings.home-manager = {
      programs.home-manager.enable = true;
      home.stateVersion = config.system.stateVersion;
    };
  };
}

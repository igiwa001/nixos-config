{
  lib,
  my-lib,
  config,
  inputs,
  ...
}: let
  cfg = config.settings;
in {
  imports = [inputs.home-manager.nixosModules.home-manager];

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

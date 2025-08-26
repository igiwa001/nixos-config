{
  lib,
  config,
  ...
}: let
  cfg = config.settings.programs.podman;
in {
  options.settings.programs.podman.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config.virtualisation = lib.mkIf cfg.enable {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}

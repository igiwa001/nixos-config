{
  lib,
  config,
  ...
}: let
  cfg = config.settings.programs.podman;
in {
  options.settings.programs.podman.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf cfg.enable {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
    settings.user.groups = ["podman"];
  };
}

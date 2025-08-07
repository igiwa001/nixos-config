{
  lib,
  config,
  ...
}: let
  cfg = config.settings.shell.nh;
in {
  options.settings.shell.nh.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings.home-manager.programs.nh = lib.mkIf cfg.enable {
    enable = true;
    flake = /etc/nixos;
  };
}

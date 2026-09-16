{
  lib,
  config,
  ...
}: let
  cfg = config.settings.programs.nh;
in {
  options.settings.programs.nh.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings.home-manager.programs.nh = lib.mkIf cfg.enable {
    enable = true;
    flake = /etc/nixos;
  };
}

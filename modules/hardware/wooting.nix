{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.hardware.wooting;
in {
  options.settings.hardware.wooting = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    wootility = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.wooting.enable = true;
    environment.systemPackages =
      [pkgs.wooting-udev-rules]
      ++ lib.optionals cfg.wootility [pkgs.wootility];
  };
}

{
  lib,
  config,
  ...
}: let
  cfg = config.settings.programs.sddm;
in {
  options.settings.programs.sddm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    wayland = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config.services = lib.mkIf cfg.enable {
    displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      wayland.enable = cfg.wayland;
    };
    xserver.enable = lib.mkIf (!cfg.wayland) true;
  };
}

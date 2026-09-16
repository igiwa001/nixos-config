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

  config = lib.mkIf cfg.enable {
    services = {
      displayManager.sddm = {
        enable = true;
        enableHidpi = true;
        wayland.enable = cfg.wayland;
      };
      xserver.enable = lib.mkIf (!cfg.wayland) true;
    };

    security.pam.services.sddm.enableGnomeKeyring = true;
  };
}

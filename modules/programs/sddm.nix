{
  lib,
  config,
  ...
}: {
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

  config = lib.mkIf config.settings.programs.sddm.enable {
    services = {
      displayManager.sddm = {
        enable = true;
        enableHidpi = true;
        wayland.enable = config.settings.programs.sddm.wayland;
      };
      xserver.enable = lib.mkIf (!config.settings.programs.sddm.wayland) true;
    };
  };
}

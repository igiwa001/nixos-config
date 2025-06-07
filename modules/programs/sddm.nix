{
  lib,
  config,
  ...
}: {
  options.settings.programs = {
    sddm = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.settings.programs.sddm {
    services.displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      wayland.enable = true;
    };
  };
}

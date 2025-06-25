{
  lib,
  config,
  ...
}: let
  cfg = config.settings.hyprland.hypridle;
in {
  options.settings.hyprland.hypridle.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings.home-manager.services.hypridle = lib.mkIf cfg.enable {
    enable = true;
    settings.general = {
      lock_cmd = "pidof hyprlock || hyprlock";
      before_sleep_cmd = "loginctl lock-session";
      after_sleep_cmd = "hyprctl dispatch dpms on";
    };
  };
}

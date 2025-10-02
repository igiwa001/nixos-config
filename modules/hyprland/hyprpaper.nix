{
  lib,
  config,
  ...
}: let
  cfg = config.settings.hyprland.hyprpaper;
  inherit (config.settings.hyprland) wallpaper;
in {
  options.settings.hyprland.hyprpaper.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.hyprland.enable;
  };

  config.settings.home-manager.services.hyprpaper = lib.mkIf cfg.enable {
    enable = true;
    settings = {
      preload = [wallpaper];
      wallpaper = [",${wallpaper}"];
    };
  };
}

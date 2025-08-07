{
  lib,
  config,
  ...
}: let
  cfg = config.settings.hyprland.hyprpaper;
  inherit (config.settings) wallpaper;
in {
  options.settings.hyprland.hyprpaper.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.hyprland.enable;
  };

  config.settings = lib.mkIf cfg.enable {
    home-manager.services.hyprpaper = {
      enable = true;
      settings = {
        preload = [wallpaper.path];
        wallpaper = [",${wallpaper.path}"];
      };
    };
    wallpaper.onChange = "hyprctl hyprpaper reload ,${wallpaper.path} >/dev/null 2>&1";
  };
}

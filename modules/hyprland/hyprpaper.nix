{
  lib,
  config,
  ...
}: let
  cfg = config.settings.hyprland.hyprpaper;
  wallpaper = config.settings.wallpaper;
in {
  options.settings.hyprland.hyprpaper.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.hyprland.enable;
  };

  config.settings = lib.mkIf cfg.enable {
    home-manager.services.hyprpaper = {
      enable = true;
      settings = {
        preload = ["~/${wallpaper.directory}/${wallpaper.default}"];
        wallpaper = [",~/${wallpaper.directory}/${wallpaper.default}"];
      };
    };
    wallpaper.onChange = "hyprctl hyprpaper reload ,~/${wallpaper.directory}/$WALLPAPER >/dev/null 2>&1";
  };
}

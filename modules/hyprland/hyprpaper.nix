{
  lib,
  config,
  ...
}: let
  cfg = config.settings.hyprland.hyprshot;
  wallpaper = config.settings.wallpaper;
in {
  options.settings.hyprland.hyprshot.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
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

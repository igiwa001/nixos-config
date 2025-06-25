{
  lib,
  config,
  ...
}: let
  cfg = config.settings.hyprland.hyprlock;
  wallpaper = config.settings.wallpaper;
  setBackground = image: "ln -sf ~/${wallpaper.directory}/${image} ~/.config/hypr/wallpaper";
in {
  imports = [./config.nix];

  options.settings.hyprland.hyprlock = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    wallpaper = lib.mkOption {
      type = lib.types.str;
      default = "~/.config/hypr/wallpaper";
    };
  };

  config.settings = lib.mkIf cfg.enable {
    home-manager.programs.hyprlock.enable = true;

    hyprland.settings = {
      bind = ["SUPER, ESCAPE, exec, loginctl lock-session"];
      exec-once = [(setBackground wallpaper.default)];
    };

    wallpaper.onChange = setBackground "$WALLPAPER";
  };
}

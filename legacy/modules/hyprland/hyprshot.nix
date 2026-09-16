{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.hyprland.hyprshot;
in {
  options.settings.hyprland.hyprshot.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.hyprland.enable;
  };

  config.settings = lib.mkIf cfg.enable {
    home-manager.home = {
      packages = [pkgs.hyprshot];
      sessionVariables.HYPRSHOT_DIR = "${config.settings.user.homeDirectory}/Pictures";
    };
    hyprland.settings.bind = [
      ", Print, exec, hyprshot -z -m region"
      "SHIFT, Print, exec, hyprshot -z -m window"
      "CTRL, Print, exec, hyprshot -z -m output"
    ];
  };
}

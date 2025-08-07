{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.hyprland.clipse;
  inherit (config.settings) defaults;
in {
  options.settings.hyprland.clipse.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.hyprland.enable;
  };

  config = lib.mkIf cfg.enable {
    settings = {
      hyprland.settings = {
        exec-once = ["clipse --listen"];
        windowrulev2 = [
          "float, class:(clipse)"
          "size 622 652, class:(clipse)"
        ];
        bind = ["SUPER, V, exec, kill $(pidof clipse) || ${defaults.terminal} --class clipse -e clipse"];
      };
      home-manager.home.packages = [pkgs.clipse];
    };
    environment.systemPackages = [pkgs.wl-clipboard];
  };
}

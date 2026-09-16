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
        windowrule = ["match:class clipse, float on, size 622 652"];
        bind = ["SUPER, V, exec, kill $(pidof clipse) || ${defaults.terminal} --class clipse -e clipse"];
      };
      home-manager.home.packages = [pkgs.clipse];
    };
    environment.systemPackages = [pkgs.wl-clipboard];
  };
}

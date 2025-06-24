{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.hyprland.rofi;
in {
  options.settings.hyprland.rofi.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings = lib.mkIf cfg.enable {
    home-manager.programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = ./theme.rasi;
    };
    hyprland.settings.bindr = [
      "SUPER, Super_L, exec, kill $(pidof rofi) || rofi -show drun"
    ];
  };
}

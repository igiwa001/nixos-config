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
    default = config.settings.hyprland.enable;
  };

  config.settings = lib.mkIf cfg.enable {
    home-manager.programs.rofi = {
      enable = true;
      theme = ./theme.rasi;
    };
    hyprland.settings.bindr = [
      "SUPER, Super_L, exec, kill $(pidof rofi) || rofi -show drun"
    ];
    fonts.packages = [pkgs.nerd-fonts.fira-mono];
  };
}

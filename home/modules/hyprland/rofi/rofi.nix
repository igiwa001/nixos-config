{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = ./theme.rasi;
  };
  wayland.windowManager.hyprland.settings.bindr = [
    "SUPER, Super_L, exec, kill $(pidof rofi) || rofi -show drun"
  ];
}

{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 4;

        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = ["clock"];
        modules-right = ["network" "battery" "tray"];

        "hyprland/window" = {
          max-length = 50;
          separate-outputs = true;
        };
        "tray" = {
          spacing = 10;
        };
        "clock" = {
          timezone = "Europe/Oslo";
          #format = "{%M %d %H:%M}";
        };
      };
    };
  };
}

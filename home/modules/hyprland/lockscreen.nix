{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
    };
  };
  programs.hyprlock = {
    enable = true;
    settings = {
      background.color = "rgb(2f4f4f)";
      input-field = {
        size = "250, 60";
        outline_thickness = 2;
      };
    };
  };
}

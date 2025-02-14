{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home. packages = [pkgs.hyprshot];
  wayland.windowManager.hyprland.settings = {
    env = ["HYPRSHOT_DIR, ${config.home.homeDirectory}/Pictures"];
    bind = [
      ", Print, exec, hyprshot -z -m region"
      "SHIFT, Print, exec, hyprshot -z -m window"
      "CTRL, Print, exec, hyprshot -z -m output"
    ];
  };
}

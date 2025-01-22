{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.clipse
    pkgs.wl-clipboard
  ];
  wayland.windowManager.hyprland.settings = {
    exec-once = ["clipse --listen"];
    bind = ["SUPER, V, exec, kitty --class clipse -e 'clipse'"];
    windowrulev2 = [
      "float, class:(clipse)"
      "size 622 652, class:(clipse)"
    ];
  };
}

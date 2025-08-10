{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.hyprland.playerctl;
  playerctl-bin = "${pkgs.playerctl}/bin/playerctl";
in {
  options.settings.hyprland.playerctl.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.hyprland.enable;
  };

  config.settings.hyprland.settings.bind = lib.mkIf cfg.enable [
    ", XF86AudioPlay, exec, ${playerctl-bin} play-pause"
    ", XF86AudioPause, exec, ${playerctl-bin} pause"
    ", XF86AudioStop, exec, ${playerctl-bin} stop"
    ", XF86AudioNext, exec, ${playerctl-bin} next"
    ", XF86AudioPrev, exec, ${playerctl-bin} previous"
  ];
}

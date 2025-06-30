{
  lib,
  config,
  ...
}: let
  cfg = config.settings.hyprland;
in
  lib.mkIf cfg.enable {
    settings.hyprland.settings.monitor = [
      "desc:LG Electronics LG ULTRAGEAR 404NTGYA6311, preferred, 0x0, 1.33"
      "desc:AOC 24P2W1DG5 PSMM1HA001150, highres, 1920x-400, 1.2, transform, 3"
      "desc:AOC 2470W GGJL1HA182550, highres, auto-up, auto"
      "desc:AOC Q27V5C 18DQ1HA025220, preferred, auto-up, 1.25"
    ];
  }

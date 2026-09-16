{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.hyprland.hyprlock;
in {
  imports = [./config.nix];

  options.settings.hyprland.hyprlock.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.hyprland.enable;
  };

  config.settings = lib.mkIf cfg.enable {
    home-manager.programs.hyprlock.enable = true;
    fonts.packages = [pkgs.nerd-fonts.fira-mono];
    hyprland.settings.bind = ["SUPER, ESCAPE, exec, loginctl lock-session"];
  };
}

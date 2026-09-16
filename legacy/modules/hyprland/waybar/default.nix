{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.hyprland.waybar;
in {
  imports = [./config.nix];

  options.settings.hyprland.waybar.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.hyprland.enable;
  };

  config.settings = lib.mkIf cfg.enable {
    home-manager.programs.waybar = {
      enable = true;
      systemd.enable = true;
      style = ./style.css;
    };

    fonts.packages = [pkgs.nerd-fonts.fira-mono];
    hyprland.settings.bind = [
      "SUPER, W, exec, systemctl --user $(if systemctl --user is-active --quiet waybar; then echo stop; else echo start; fi) waybar"
    ];
  };
}

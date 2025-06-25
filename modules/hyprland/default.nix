{
  lib,
  my-lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.hyprland;
in {
  imports = [
    ./swayosd.nix
    ./monitors.nix
    ./settings.nix
    ./binds.nix
    ./waybar
    ./rofi
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock
  ];

  options.settings.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    xwayland = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    settings = lib.mkOption {
      type = my-lib.types.mergeableAnything;
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = cfg.xwayland;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    settings.home-manager.wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      xwayland.enable = cfg.xwayland;
      settings = cfg.settings;
    };
  };
}

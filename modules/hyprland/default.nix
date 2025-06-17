{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./swayosd.nix
    ./monitors.nix
    ./settings.nix
    ./binds.nix
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
      type = lib.types.attrs;
      default = {};
    };
  };

  config = lib.mkIf config.settings.hyprland.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = config.settings.hyprland.xwayland;
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

    home-manager.users.${config.settings.user.username}.wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      xwayland.enable = config.settings.hyprland.xwayland;
      settings = config.settings.hyprland.settings;
    };
  };
}

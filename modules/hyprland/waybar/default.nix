{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./config.nix];

  options.settings.hyprland.waybar = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.settings.hyprland.waybar.enable {
    home-manager.users.${config.settings.user.username} = {
      programs.waybar = {
        enable = true;
        systemd.enable = true;
        style = ./style.css;
      };
    };

    settings = {
      hyprland.settings.bind = [
        "SUPER, W, exec, systemctl --user $(if systemctl --user is-active --quiet waybar; then echo stop; else echo start; fi) waybar"
      ];
      fonts.packages = [pkgs.nerd-fonts.fira-mono];
    };
  };
}

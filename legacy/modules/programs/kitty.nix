{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.programs.kitty;
in {
  options.settings.programs.kitty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config.settings.home-manager.programs.kitty = lib.mkIf cfg.enable {
    enable = true;
    shellIntegration.enableBashIntegration = true;

    font = {
      package = pkgs.nerd-fonts.fira-code;
      name = "Fira Code Nerd Font";
    };

    settings = {
      linux_display_server = "wayland";
      confirm_os_window_close = 2;
      disable_ligatures = "never";
      scrollback_indicator_opacity = 0;
      mouse_hide_wait = -1;
      background_opacity = 0.7;
    };
  };
}

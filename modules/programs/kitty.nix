{
  lib,
  config,
  ...
}: {
  options.settings.programs.kitty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.settings.programs.kitty.enable {
    home-manager.users.${config.settings.user.username}.programs.kitty = {
      enable = true;
      shellIntegration.enableBashIntegration = true;
      settings = {
        linux_display_server = "wayland";
        confirm_os_window_close = 2;
        disable_ligatures = "never";
        scrollback_indicator_opacity = 0;
        mouse_hide_wait = -1;
        background_opacity = 0.7;
      };
    };
  };
}

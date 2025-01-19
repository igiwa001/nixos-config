{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.kitty = {
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
}

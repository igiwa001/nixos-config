{
  lib,
  config,
  ...
}: let
  cfg = config.settings.hyprland;
in {
  options.settings.hyprland.autoreload = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings.hyprland.settings = lib.mkIf cfg.enable {
    general = {
      gaps_in = 3;
      gaps_out = 8;
      "col.active_border" = "rgba(4,194,222,96)";
    };

    decoration = {
      rounding = 10;
      rounding_power = 3;
    };

    input = {
      kb_layout = config.settings.locale.keymap;
      repeat_delay = 200;
      follow_mouse = 2;

      touchpad = {
        disable_while_typing = false;
        natural_scroll = true;
        drag_lock = true;
      };
    };

    gesture = [
      "3, horizontal, workspace"
      "4, horizontal, workspace"
    ];

    misc = {
      disable_hyprland_logo = cfg.hyprpaper.enable;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
      disable_autoreload = !cfg.autoreload;
      focus_on_activate = true;
    };

    binds = {
      movefocus_cycles_fullscreen = true;
    };

    xwayland = {
      enabled = cfg.xwayland;
      force_zero_scaling = true;
    };

    cursor = {
      inactive_timeout = 3;
      hide_on_key_press = true;
    };

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
    };

    experimental = {
      xx_color_management_v4 = true;
    };

    animation = [
      "global, 1, 3, default"
    ];

    dwindle = {
      force_split = 2;
      preserve_split = true;
    };
  };
}

{
  lib,
  config,
  ...
}: {
  options.settings.hyprland = {
    autoreload = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    home-manager.users.${config.settings.user.username}.wayland.windowManager.hyprland.settings = {
      general = {
        gaps_in = 3;
        gaps_out = 8;
        "col.active_border" = "rgb(04c2de)";
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

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_min_fingers = true;
      };

      misc = {
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        disable_autoreload = !config.settings.hyprland.autoreload;
        focus_on_activate = true;
        initial_workspace_tracking = 2;
      };

      binds = {
        movefocus_cycles_fullscreen = true;
      };

      xwayland = {
        enabled = config.settings.hyprland.xwayland;
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
  };
}

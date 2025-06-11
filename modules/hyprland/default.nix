{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./swayosd.nix
    ./monitors.nix
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

    autoreload = lib.mkOption {
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
      xwayland.enable = config.settings.hyprland.xwayland;

      settings = lib.mkMerge [
        {
          general = {
            gaps_in = 3;
            gaps_out = 10;
            "col.active_border" = "rgb(04c2de)";
          };
          decoration.rounding = 10;

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
            force_default_wallpaper = 1;
            disable_autoreload = !config.settings.hyprland.autoreload;
          };

          binds.workspace_back_and_forth = true;

          render.direct_scanout = true;

          cursor = {
            inactive_timeout = 3;
            no_warps = true;
            hide_on_key_press = true;
          };

          bindm = [
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
          ];

          bind =
            [
              "SUPER, Q, killactive"
              "SUPER, ESCAPE, exec, loginctl lock-session"

              "SUPER, F, fullscreen, 1"
              "SUPERSHIFT, F, fullscreen, 0"
              "SUPER, G, togglefloating"

              "SUPER, H, movefocus, l"
              "SUPER, J, movefocus, d"
              "SUPER, K, movefocus, u"
              "SUPER, L, movefocus, r"

              "SUPERSHIFT, H, swapwindow, l"
              "SUPERSHIFT, J, swapwindow, d"
              "SUPERSHIFT, K, swapwindow, u"
              "SUPERSHIFT, L, swapwindow, r"

              "SUPER, 1, workspace, 1"
              "SUPER, 2, workspace, 2"
              "SUPER, 3, workspace, 3"
              "SUPER, 4, workspace, 4"
              "SUPER, 5, workspace, 5"
              "SUPER, 6, workspace, 6"
              "SUPER, 7, workspace, 7"
              "SUPER, 8, workspace, 8"
              "SUPER, 9, workspace, 9"
              "SUPER, 0, workspace, 10"

              "SUPERSHIFT, 1, movetoworkspace, 1"
              "SUPERSHIFT, 2, movetoworkspace, 2"
              "SUPERSHIFT, 3, movetoworkspace, 3"
              "SUPERSHIFT, 4, movetoworkspace, 4"
              "SUPERSHIFT, 5, movetoworkspace, 5"
              "SUPERSHIFT, 6, movetoworkspace, 6"
              "SUPERSHIFT, 7, movetoworkspace, 7"
              "SUPERSHIFT, 8, movetoworkspace, 8"
              "SUPERSHIFT, 9, movetoworkspace, 9"
              "SUPERSHIFT, 0, movetoworkspace, 10"

              "ALT, H, movewindow, mon:l"
              "ALT, J, movewindow, mon:d"
              "ALT, K, movewindow, mon:u"
              "ALT, L, movewindow, mon:r"

              "ALTSHIFT, H, movecurrentworkspacetomonitor, l"
              "ALTSHIFT, J, movecurrentworkspacetomonitor, d"
              "ALTSHIFT, K, movecurrentworkspacetomonitor, u"
              "ALTSHIFT, L, movecurrentworkspacetomonitor, r"
            ]
            ++ lib.optionals (config.settings.defaults.terminal != null) ["SUPER, T, exec, ${config.settings.defaults.terminal}"]
            ++ lib.optionals (config.settings.defaults.browser != null) ["SUPER, B, exec, ${config.settings.defaults.browser}"];
        }
        config.settings.hyprland.settings
      ];
    };
  };
}

{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./waybar.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      general = {
        gaps_out = 10;
        allow_tearing = true;
        "col.active_border" = "rgb(04c2de)";
      };

      decoration = {
        rounding = 10;
        inactive_opacity = 0.95;
      };

      input = {
        kb_layout = "no";
        repeat_delay = 200;
        follow_mouse = 2;
        touchpad = {
          disable_while_typing = false;
          natural_scroll = true;
          drag_lock = true;
        };
      };

      misc = {
        disable_splash_rendering = true;
        vrr = true;
      };

      animation = [
        "global, 1, 3, default"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      bind = [
        "SUPER, Q, killactive"
        "SUPER, ESCAPE, exec, loginctl lock-session"

        "SUPER, F, fullscreen, 1"
        "SUPERSHIFT, F, fullscreen, 0"
        "SUPER, G, togglefloating"

        "ALT, TAB, cyclenext"
        "ALT, TAB, bringactivetotop"
        "ALTSHIFT, TAB, cyclenext, prev"
        "ALTSHIFT, TAB, bringactivetotop"

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

        "ALT, H, workspace, e-1"
        "ALT, L, workspace, e+1"
        "ALTSHIFT, H, movetoworkspace, e-1"
        "ALTSHIFT, L, movetoworkspace, e+1"

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

        "SUPER, T, exec, kitty"
        "SUPER, B, exec, firefox"
      ];
    };
  };
}

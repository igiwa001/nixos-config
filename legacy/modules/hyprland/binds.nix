{
  lib,
  config,
  ...
}: let
  inherit (config.settings) defaults;
  cfg = config.settings.hyprland;
in {
  settings.hyprland.settings = lib.mkIf cfg.enable {
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    bind =
      [
        "SUPER, Q, killactive"

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
      ++ lib.optionals (defaults.terminal != null) ["SUPER, T, exec, ${defaults.terminal}"]
      ++ lib.optionals (defaults.browser != null) ["SUPER, B, exec, ${defaults.browser}"];
  };
}

{
  lib,
  config,
  ...
}: let
  cfg = config.settings.hyprland.hyprlock;
in {
  options.settings.hyprland.hyprlock.enableFprint = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config.settings.home-manager.programs.hyprlock.settings = lib.mkIf cfg.enable {
    auth.fingerprint.enabled = cfg.enableFprint;

    background = {
      path = cfg.wallpaper;
      blur_passes = 2;
      contrast = 0.8916;
      brightness = 0.8172;
      vibrancy = 0.1696;
      vibrancy_darkness = 0;
    };

    input-field = {
      size = "250, 60";
      outline_thickness = 2;
      dots_size = 0.2;
      dots_spacing = 0.2;
      dots_center = true;
      outer_color = "rgba(0, 0, 0, 0)";
      inner_color = "rgba(100, 114, 125, 0.4)";
      font_color = "rgb(200, 200, 200)";
      fade_on_empty = false;
      font_family = "FiraMono Nerd Font Bold";
      placeholder_text = ''<i><span foreground="##ffffff99">Enter Pass</span></i>'';
      hide_input = false;
      position = "0, -185";
      halign = "center";
      valign = "center";
    };

    shape = {
      size = "250, 60";
      color = "rgba(255, 255, 255, .1)";
      rounding = -1;
      border_size = 0;
      border_color = "rgba(255, 255, 255, 0)";
      position = "0, -100";
      halign = "center";
      valign = "center";
    };

    label = [
      {
        text = ''cmd[update:1000] echo "<span>$(date +"%H:%M")</span>"'';
        color = "rgba(216, 222, 233, 0.70)";
        font_size = 130;
        font_family = "FiraMono Nerd Font Bold";
        position = "0, 230";
        halign = "center";
        valign = "center";
      }

      {
        text = ''cmd[update:1000] echo -e "$(date +"%A, %d %B")"'';
        color = "rgba(216, 222, 233, 0.70)";
        font_size = 30;
        font_family = "FiraMono Nerd Font Bold";
        position = "0, 95";
        halign = "center";
        valign = "center";
      }
      {
        text = "  $USER";
        color = "rgba(216, 222, 233, 0.80)";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        font_size = 18;
        font_family = "FiraMono Nerd Font Bold";
        position = "0, -100";
        halign = "center";
        valign = "center";
      }
    ];
  };
}

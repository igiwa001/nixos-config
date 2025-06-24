{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.hyprland;
in {
  options.settings.hyprland.swayosd = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings = let
    # Speaker mute
    unmute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0";
    toggle_mute = "swayosd-client --output-volume mute-toggle";

    # Speaker volume
    raise_volume = "swayosd-client --output-volume raise";
    lower_volume = "swayosd-client --output-volume lower";

    # Microphone mute
    toggle_mic = "swayosd-client --input-volume mute-toggle";

    # Thinkpad microphone LED workaround
    get_mic_status = "wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -c MUTED";
    update_mic_led = "brightnessctl -d platform::micmute set $(${get_mic_status})";

    # Monitor brightness
    raise_brightness = "swayosd-client --brightness raise";
    lower_brightness = "swayosd-client --brightness lower";

    # Night light (blue light filter)
    toggle_nightlight = "kill $(pidof hyprsunset) || hyprsunset -t 3500 &";
  in
    lib.mkIf cfg.swayosd {
      home-manager = {
        services.swayosd.enable = true;
        home.packages = [
          pkgs.brightnessctl
          pkgs.hyprsunset
        ];
      };

      hyprland.settings = {
        bindel = [
          ", XF86AudioRaiseVolume, exec, ${unmute} && ${raise_volume}"
          ", XF86AudioLowerVolume, exec, ${unmute} && ${lower_volume}"
          ", XF86MonBrightnessDown, exec, ${lower_brightness}"
          ", XF86MonBrightnessUp, exec, ${raise_brightness}"
        ];
        bindl = [
          ", XF86AudioMute, exec, ${toggle_mute}"
          ", XF86AudioMicMute, exec, ${toggle_mic} && ${update_mic_led}"
          ", XF86Favorites, exec, ${toggle_nightlight}"
        ];
      };
    };
}

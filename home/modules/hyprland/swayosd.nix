{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  unmute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0";
  toggle_mute = "swayosd-client --output-volume mute-toggle";
  raise_volume = "swayosd-client --output-volume raise";
  lower_volume = "swayosd-client --output-volume lower";
  toggle_mic = "swayosd-client --input-volume mute-toggle";
  brightness_raise = "swayosd-client --brightness raise";
  brightness_lower = "swayosd-client --brightness lower";
  mic_status = "wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -c MUTED";
  update_mic_led = "brightnessctl -d platform::micmute set $(${mic_status})";
in {
  wayland.windowManager.hyprland.settings = {
    bindel = [
      ", XF86AudioRaiseVolume, exec, ${unmute} && ${raise_volume}"
      ", XF86AudioLowerVolume, exec, ${unmute} && ${lower_volume}"
      ", XF86MonBrightnessDown, exec, ${brightness_lower}"
      ", XF86MonBrightnessUp, exec, ${brightness_raise}"
    ];
    bindl = [
      ", XF86AudioMute, exec, ${toggle_mute}"
      ", XF86AudioMicMute, exec, ${toggle_mic} && ${update_mic_led}"
    ];
  };
  services.swayosd.enable = true;
  home.packages = [pkgs.brightnessctl];
}

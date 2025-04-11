{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    themeConfig = {
      PartialBlur = false;
    };
  };
in {
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    extraPackages = [sddm-astronaut];
  };
  environment.systemPackages = [sddm-astronaut];
}

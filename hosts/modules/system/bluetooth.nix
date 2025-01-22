{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      Policy.AutoEnable = false;
    };
  };
  services.blueman.enable = true;
}

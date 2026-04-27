{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.nixos-hardware.nixosModules) raspberry-pi-4;
in {
  imports = [
    ./hardware-configuration.nix
    raspberry-pi-4
  ];

  # Enable GPIO pins
  hardware.raspberry-pi."4".gpio.enable = true;
  settings.user.groups = ["gpio"];

  # Enable 1-wire interface
  boot.kernelModules = ["pwm_bcm2835" "w1-gpio" "w1-therm"];
  hardware.deviceTree = {
    enable = true;
    filter = "*-rpi-*.dtb";
    overlays = [
      {
        name = "pwm-2chan";
        dtboFile = "${pkgs.device-tree_rpi.overlays}/pwm-2chan.dtbo";
      }
      {
        name = "w1-gpio";
        dtboFile = "${pkgs.device-tree_rpi.overlays}/w1-gpio.dtbo";
      }
    ];
  };

  settings = {
    system.stateVersion = "25.05";
    networking.hostname = "rpi4";
    nixos.cores = 4;
    bootloader.loader = "generic";

    services.sshd.enable = true;

    hyprland.enable = false;
    programs = {
      discord.enable = false;
      firefox.enable = false;
      kitty.enable = false;
      libreoffice.enable = false;
      noisetorch.enable = false;
      sddm.enable = false;
      slack.enable = false;
      spotify.enable = false;
      steam.enable = false;
      teams.enable = false;
      bottles.enable = false;
    };
  };
}

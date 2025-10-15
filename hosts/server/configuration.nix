{inputs, ...}: let
  inherit
    (inputs.nixos-hardware.nixosModules)
    common-pc
    common-cpu-intel-cpu-only
    ;
in {
  imports = [
    ./hardware-configuration.nix
    common-pc
    common-cpu-intel-cpu-only
  ];

  settings = {
    system.stateVersion = "25.05";
    networking.hostname = "server";
    nixos.cores = 4;
    bootloader = {
      loader = "grub";
      grub.device = "/dev/sda";
    };
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
    };
  };
}

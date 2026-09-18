{
  imports = [./fancontrol.nix];

  settings = {
    system.stateVersion = "25.05";
    networking.hostname = "server";
    nixos.cores = 4;
    bootloader = {
      loader = "grub";
      grub.device = "/dev/sda";
    };
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
      bottles.enable = false;
    };
  };
}

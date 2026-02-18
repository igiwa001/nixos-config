_: {
  imports = [./hardware-configuration.nix];

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
    };
  };
}

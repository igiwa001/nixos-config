{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  settings = {
    system.stateVersion = "24.11";
    networking.hostname = "desktop-modular";
    nixos.cores = 24;
    hardware.wooting = true;
    programs.lact.enable = true;
  };

  # TEMPORARY
  settings.neovim.enable = false;
  settings.nvim-old.enable = true;
}

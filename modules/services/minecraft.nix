{
  inputs,
  lib,
  my-lib,
  config,
  ...
}: let
  inherit (inputs) nix-minecraft;
  cfg = config.settings.services.minecraft;
in {
  imports = [
    nix-minecraft.nixosModules.minecraft-servers
  ];

  options.settings.services.minecraft = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    servers = lib.mkOption {
      type = my-lib.types.mergeableAnything;
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [nix-minecraft.overlay];
    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
      inherit (cfg) servers;
      managementSystem = {
        tmux.enable = false;
        systemd-socket.enable = true;
      };
    };
  };
}

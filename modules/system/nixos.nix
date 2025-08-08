{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.nixos;
in {
  options.settings.nixos = {
    gc = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    optimise = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    cores = lib.mkOption {
      type = with lib.types; either ints.positive (enum ["auto"]);
      default = "auto";
    };

    unfree = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    boot.kernelPackages = pkgs.linuxPackages_latest;

    nix = {
      channel.enable = false;

      gc = lib.mkIf cfg.gc {
        automatic = true;
        persistent = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      optimise = lib.mkIf cfg.optimise {
        automatic = true;
        dates = ["weekly"];
      };

      settings = {
        experimental-features = ["flakes" "nix-command"];
        auto-optimise-store = cfg.optimise;
        max-jobs = cfg.cores;
      };

      registry.pkgs = {
        from = {
          type = "indirect";
          id = "pkgs";
        };
        to = {
          type = "github";
          owner = "igiwa001";
          repo = "nixos-config";
          ref = "9b978d9293b171b4e546489c85c793ac00319825";
        };
      };
    };

    nixpkgs.config.allowUnfree = cfg.unfree;
    documentation.nixos.enable = false;
  };
}

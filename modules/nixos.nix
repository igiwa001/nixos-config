{
  lib,
  config,
  ...
}: {
  options.nixos = {
    gc = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    optimise = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    cores = lib.mkOption {
      type = lib.types.ints.unsigned;
      default = 0;
    };

    unfree = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    nix = {
      channel.enable = false;

      gc = lib.mkIf config.nixos.gc {
        automatic = true;
        persistent = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
      };

      optimise = lib.mkIf config.nixos.optimise {
        automatic = true;
        dates = ["weekly"];
      };

      settings = {
        experimental-features = ["flakes" "nix-command"];
        auto-optimise-store = config.nixos.optimise;
        max-jobs = lib.mkIf (config.nixos.cores != 0) config.nixos.cores;
      };
    };

    nixpkgs.config = lib.mkIf config.nixos.unfree {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };

    documentation.nixos.enable = false;
  };
}

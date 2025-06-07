{
  lib,
  config,
  ...
}: {
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
    nix = {
      channel.enable = false;

      gc = lib.mkIf config.settings.nixos.gc {
        automatic = true;
        persistent = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
      };

      optimise = lib.mkIf config.settings.nixos.optimise {
        automatic = true;
        dates = ["weekly"];
      };

      settings = {
        experimental-features = ["flakes" "nix-command"];
        auto-optimise-store = config.settings.nixos.optimise;
        max-jobs = config.settings.nixos.cores;
      };
    };

    nixpkgs.config = lib.mkIf config.settings.nixos.unfree {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };

    documentation.nixos.enable = false;
  };
}

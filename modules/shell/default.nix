{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.shell;
in {
  imports = [./git.nix ./bash.nix];

  options.settings.shell = {
    eza = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    zoxide = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    nh = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config.settings.home-manager = {
    programs.eza.enable = cfg.eza;
    home.shellAliases.tree = lib.mkIf cfg.eza "eza -T";

    programs.zoxide = lib.mkIf cfg.zoxide {
      enable = true;
      options = ["--cmd cd"];
    };

    programs.nh = lib.mkIf cfg.nh {
      enable = true;
      flake = "${config.settings.user.homeDirectory}/.dotfiles";
    };

    home.packages = [
      pkgs.screen
      pkgs.nix-output-monitor
      pkgs.google-cloud-sdk
      pkgs.pnpm
      pkgs.nodejs_22
    ];
  };
}

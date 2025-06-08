{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./git.nix];

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

  config = {
    home-manager.users.${config.settings.user.username} = {
      programs.eza.enable = config.settings.shell.eza;
      home.shellAliases.tree = lib.mkIf config.settings.shell.eza "eza -T";

      programs.zoxide = lib.mkIf config.settings.shell.zoxide {
        enable = true;
        options = ["--cmd cd"];
      };

      programs.nh = {
        enable = true;
        flake = "${config.home-manager.users.${config.settings.user.username}.home.homeDirectory}/.dotfiles";
      };

      home.packages = [
        pkgs.screen
        pkgs.nix-output-monitor
        pkgs.google-cloud-sdk
        pkgs.pnpm
        pkgs.nodejs_22
      ];
    };
  };
}

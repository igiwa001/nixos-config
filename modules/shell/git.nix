{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.shell.git;
in {
  options.settings.shell.git = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    name = lib.mkOption {
      type = lib.types.str;
      default = "Igor Iwanicki";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "igor.iwanicki@protonmail.com";
    };

    lazygit = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    gh-cli = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config.settings.home-manager = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;
      userName = cfg.name;
      userEmail = cfg.email;
      extraConfig.credential.helper = "libsecret";
    };

    programs.lazygit.enable = cfg.lazygit;
    home.shellAliases.lgit = lib.mkIf cfg.lazygit "lazygit";

    programs.gh.enable = cfg.gh-cli;
  };
}

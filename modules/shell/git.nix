{
  lib,
  config,
  pkgs,
  ...
}: {
  options.settings.shell.git = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    username = lib.mkOption {
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

  config.home-manager.users.${config.settings.user.username} = lib.mkIf config.settings.shell.git.enable {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;
      userName = config.settings.shell.git.username;
      userEmail = config.settings.shell.git.email;
      extraConfig.credential.helper = "libsecret";
    };

    programs.lazygit.enable = config.settings.shell.git.lazygit;
    home.shellAliases.lgit = lib.mkIf config.settings.shell.git.lazygit "lazygit";

    programs.gh.enable = config.settings.shell.git.gh-cli;
  };
}

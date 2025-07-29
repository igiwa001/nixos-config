{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.settings.nvim-old;
in {
  options.settings.nvim-old.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config.home-manager.users.${config.settings.user.username} =
    lib.mkIf cfg.enable
    (import
    ../home/modules/neovim/neovim.nix {inherit lib config pkgs inputs;});
}

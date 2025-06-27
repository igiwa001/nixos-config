{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  # This is a TEMPORARY solution until I have time to modularize the neovim config properly
  home-manager.users.${config.settings.user.username} =
    import ../home/modules/neovim/neovim.nix {inherit lib config pkgs inputs;};
}

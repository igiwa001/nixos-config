{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim;
in {
  programs.nvf.settings.vim.visuals = lib.mkIf cfg.enable {
    indent-blankline = {
      enable = true;
      setupOpts.scope.enabled = false;
    };
    cellular-automaton.enable = true;
  };
}

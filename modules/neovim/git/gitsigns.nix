{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim.git.gitsigns;
in {
  options.settings.neovim.git.gitsigns = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.settings.neovim.enable;
    };

    disableMappings = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config.programs.nvf.settings.vim.git.gitsigns = lib.mkIf cfg.enable {
    enable = true;
    setupOpts = {
      update_debounce = 0;
      current_line_blame = true;
      current_line_blame_opts.delay = 50;
    };

    mappings = lib.mkIf cfg.disableMappings {
      blameLine = null;
      diffProject = null;
      diffThis = null;
      nextHunk = null;
      previewHunk = null;
      previousHunk = null;
      resetBuffer = null;
      resetHunk = null;
      stageBuffer = null;
      stageHunk = null;
      toggleBlame = null;
      toggleDeleted = null;
      undoStageHunk = null;
    };
  };
}

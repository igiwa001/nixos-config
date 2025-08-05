{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim;
in {
  programs.nvf.settings.vim = lib.mkIf cfg.enable {
    utility.oil-nvim.enable = true;
    keymaps = [
      {
        key = "-";
        action = "<CMD>Oil<CR>";
        mode = "n";
        silent = true;
        nowait = true;
      }
    ];
  };
}

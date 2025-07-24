{
  config,
  inputs,
  ...
}: let
  inherit (inputs.nvf.lib.nvim.lua) attrsetToLuaTable;
  inherit (config.programs.nvf.settings.vim.formatter.conform-nvim.setupOpts) default_format_opts;
in {
  programs.nvf.settings.vim = {
    formatter.conform-nvim = {
      enable = true;
      setupOpts = {
        format_after_save = null;
        format_on_save = null;
      };
    };

    keymaps = [
      {
        key = "<leader>fm";
        action = "<CMD>lua require('conform').format(${attrsetToLuaTable default_format_opts})<CR>";
        mode = "n";
        silent = true;
        nowait = true;
      }
    ];
  };
}

{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.settings.neovim;
in {
  imports = [
    inputs.nvf.nixosModules.nvf
    ./treesitter.nix
    ./telescope.nix
    ./languages.nix
    ./conform.nix
    ./lsp.nix
    ./colorscheme.nix
    ./lualine.nix
    ./noice.nix
    ./alpha.nix
    ./persistence.nix
    ./visuals.nix
  ];

  options.settings.neovim.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.programs.nvf = lib.mkIf cfg.enable {
    enable = true;
    defaultEditor = true;

    settings.vim = {
      enableLuaLoader = true;
      withNodeJs = false;
      withPython3 = false;
      withRuby = false;

      options = {
        expandtab = true;
        autoindent = true;
        smartindent = true;
        shiftwidth = 2;
        tabstop = 2;
        number = true;
        relativenumber = true;
        signcolumn = "auto";
        smartcase = true;
        foldenable = false;
      };

      undoFile.enable = true;
      clipboard = {
        enable = true;
        providers.wl-copy.enable = true;
        registers = "unnamedplus";
      };

      autopairs.nvim-autopairs.enable = true;
    };
  };
}

{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.neovim.mozart2;
in {
  options.settings.neovim.mozart2.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.neovim.enable;
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.mozart2-binary];
    programs.nvf.settings.vim.lazy.plugins."oz.nvim" = {
      package = pkgs.vimPlugins.oz-nvim;
      setupModule = "oz";
    };
  };
}

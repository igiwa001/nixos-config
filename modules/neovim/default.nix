{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.nixosModules.nvf
  ];

  programs.nvf = {
    enable = true;
    defaultEditor = true;

    settings.vim = {
      extraPackages = [pkgs.ripgrep];
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
      };

      undoFile.enable = true;
      clipboard = {
        enable = true;
        providers.wl-copy.enable = true;
        registers = "unnamedplus";
      };
    };
  };
}

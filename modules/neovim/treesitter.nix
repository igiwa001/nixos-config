{pkgs, ...}: {
  programs.nvf.settings.vim = {
    treesitter = {
      enable = true;
      autotagHtml = true;
      fold = true;
    };

    extraPackages = [pkgs.gcc];
  };
}

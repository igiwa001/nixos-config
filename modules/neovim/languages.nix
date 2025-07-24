{...}: {
  programs.nvf.settings.vim.languages = {
    enableDAP = true;
    enableFormat = true;
    enableTreesitter = true;
    enableExtraDiagnostics = true;

    nix.enable = true;
  };
}

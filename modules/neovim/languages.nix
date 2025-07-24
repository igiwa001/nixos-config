{...}: {
  programs.nvf.settings.vim.languages = {
    enableDAP = true;
    enableFormat = true;
    enableTreesitter = true;
    enableExtraDiagnostics = true;

    nix.enable = true;
    ts = {
      enable = true;
      format.type = "prettierd";
    };
  };
}

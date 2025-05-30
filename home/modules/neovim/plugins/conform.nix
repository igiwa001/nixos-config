{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings.formatters_by_ft = {
        nix = ["alejandra"];
        javascript = ["prettierd"];
        typescript = ["prettierd"];
        javascriptreact = ["prettierd"];
        typescriptreact = ["prettierd"];
        c = ["clang_format"];
        cpp = ["clang_format"];
        rust = ["rustfmt"];
        python = ["black"];
        json = ["prettierd"];
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>f";
        action = "<CMD>lua require('conform').format()<CR>";
        options = {
          noremap = true;
          silent = true;
          nowait = true;
        };
      }
    ];
  };
  home.packages = [
    pkgs.alejandra
    pkgs.prettierd
    pkgs.clang-tools
    pkgs.rustfmt
    pkgs.black
  ];
}

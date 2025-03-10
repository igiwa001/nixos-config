{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          ts_ls.enable = true;
          tailwindcss.enable = true;
          clangd.enable = true;
          nushell.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
            installRustfmt = true;
          };
          pylyzer.enable = true;
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>ca";
        action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
        options = {
          silent = true;
          noremap = true;
          nowait = true;
        };
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<CMD>lua vim.lsp.buf.rename()<CR>";
        options = {
          silent = true;
          noremap = true;
          nowait = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gi";
        action = "<CMD>lua vim.lsp.buf.implementation()<CR>";
        options = {
          silent = true;
          noremap = true;
          nowait = true;
        };
      }
    ];
  };
}

{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        nil_ls.enable = true;
        ts_ls.enable = true;
      };
    };
  };
}

{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    luaLoader.enable = true;
    performance = {
      byteCompileLua = {
        enable = true;
        configs = true;
        initLua = true;
        nvimRuntime = true;
        plugins = true;
      };
      combinePlugins.enable = true;
    };
  };
}

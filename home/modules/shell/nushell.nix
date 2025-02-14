{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nushell = {
    enable = true;
    shellAliases = config.home.shellAliases;
    configFile.text = ''
      $env.PROMPT_COMMAND = {|| $env.PWD | str replace $env.HOME "~"}
      $env.config = {
        show_banner: false,
        history: {
          file_format: "sqlite",
          isolation: false,
        },
        cursor_shape: {
          emacs: "line",
          vi_insert: "line",
          vi_normal: "block"
        }
      }
    '';
  };
}

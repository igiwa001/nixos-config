{...}: {
  settings.home-manager.programs.bash = {
    enable = true;
    initExtra = "[[ -f ~/.profile ]] && . ~/.profile";
  };
}

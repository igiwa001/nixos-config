{config, ...}: {
  home-manager.users.${config.settings.user.username}.programs.bash = {
    enable = true;
    initExtra = "[[ -f ~/.profile ]] && . ~/.profile";
  };
}

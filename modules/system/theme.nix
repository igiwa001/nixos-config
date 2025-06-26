{pkgs, ...}: {
  settings.home-manager = {
    qt = {
      enable = true;
      style = {
        name = "Adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
    };
  };

  environment.sessionVariables.GTK_THEME = "Adwaita-dark";
}

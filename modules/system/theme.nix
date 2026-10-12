let
  description = ''
    Configures the theme/style of the system.
    TODO: Add GTK and QT theme configuration
  '';

  cursor = {
    name = "theme/cursor";
    description = ''
      Configures the mouse pointer through home-manager.
    '';

    homeManager = {self', ...}: {
      home.pointerCursor = {
        name = "Notwaita-Black";
        size = 22;
        enable = true;
        gtk.enable = true;
        x11.enable = true;
        hyprcursor.enable = true;
        package = self'.packages.notwaita-cursor;
      };
    };
  };

  fonts = {
    name = "theme/fonts";
    description = ''
      Configures the system fonts.
    '';

    nixos = {pkgs, ...}: {
      fonts = {
        fontconfig.enable = true;
        enableDefaultPackages = true;
        packages = [pkgs.nerd-fonts.fira-mono];
      };
    };
  };
in {
  den.aspects.system.theme = {
    name = "theme";
    inherit description;
    includes = [
      cursor
      fonts
    ];
  };
}

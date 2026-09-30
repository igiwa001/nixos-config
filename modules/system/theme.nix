let
  description = ''
    TODO
  '';

  cursor = {
    name = "theme/cursor";
    description = ''
      Configures the mouse pointer through home-manager.
    '';

    homeManager = {pkgs, ...}: {
      home.pointerCursor = {
        name = "Notwaita-Black";
        size = 22;
        enable = true;
        gtk.enable = true;
        x11.enable = true;
        hyprcursor.enable = true;
        package = pkgs.notwaita-cursor;
      };
    };
  };
in {
  den.aspects.system.theme = {
    name = "theme";
    inherit description;
    includes = [
      cursor
    ];
  };
}

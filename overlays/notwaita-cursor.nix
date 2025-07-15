(final: prev: {
  notwaita-cursor = prev.stdenv.mkDerivation rec {
    pname = "notwaita-cursor";
    version = "v1.0.0-alpha1";

    src = prev.fetchzip {
      url = "https://github.com/ful1e5/notwaita-cursor/releases/download/${version}/Notwaita.tar.xz";
      sha256 = "sha256-yS0pGAmoFQ4ypkcuYMH5FS2PSShl0wZtXYTBQftyZQk=";
      stripRoot = false;
    };

    installPhase = ''
      mkdir -p $out/share/icons/
      cp -r -t $out/share/icons Notwaita-{White,Gray,Black}
    '';
  };
})

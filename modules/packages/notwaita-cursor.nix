{
  perSystem = {pkgs, ...}: {
    packages.notwaita-cursor = pkgs.stdenv.mkDerivation (final: {
      pname = "notwaita-cursor";
      version = "v1.0.0-alpha1";

      src = pkgs.fetchzip {
        url = "https://github.com/ful1e5/notwaita-cursor/releases/download/${final.version}/Notwaita.tar.xz";
        sha256 = "sha256-yS0pGAmoFQ4ypkcuYMH5FS2PSShl0wZtXYTBQftyZQk=";
        stripRoot = false;
      };

      installPhase = ''
        runHook preInstall

        mkdir -p $out/share/icons
        cp -r -t $out/share/icons Notwaita-{White,Gray,Black}

        runHook postInstall
      '';
    });
  };
}

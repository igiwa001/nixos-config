(_: prev: {
  teamspeak6-server = prev.stdenv.mkDerivation (final: {
    pname = "teamspeak6-server";
    version = "v6.0.0-beta9";

    src = prev.fetchzip {
      url = "https://github.com/teamspeak/teamspeak6-server/releases/download/${final.version}/teamspeak6-server-linux-amd64.tar.xz";
      hash = "sha256-y71XWMNoY/5D+dErcObBlhSre8aAK+3supZMhxxuenk=";
      stripRoot = false;
    };

    nativeBuildInputs = [
      prev.autoPatchelfHook
      prev.stdenv.cc.cc
    ];

    installPhase = ''
      runHook preInstall

      # Install files
      mkdir -p $out/lib/teamspeak6/
      mv * $out/lib/teamspeak6/

      # Make symlink to binary
      mkdir -p $out/bin/
      ln -s $out/lib/teamspeak6/tsserver $out/bin/${final.pname}

      runHook postInstall
    '';
  });
})

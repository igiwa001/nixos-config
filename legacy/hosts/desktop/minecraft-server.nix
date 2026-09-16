{pkgs, ...}: let
  players = {
    Dgtg = "8737ed5c-6d32-42d6-a11c-229303c7db6c";
    EzT_ = "cd3354a7-0661-435c-9944-b0cc2235685c";
  };
  mods = {
    Servux = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/zQhsx8KF/versions/eu63Kj9A/servux-fabric-26.1.2-0.10.2.jar";
      sha512 = "78566cebcc5e181c68fc7f78c2f34213d634ae930f82cdfad19dd65ac4e6b24ae6d541a200b069e07e32e90b5c827d1cc1e80809da376bfbabfc8b302f9f256a";
    };
    FerriteCore = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/uXXizFIs/versions/d5ddUdiB/ferritecore-9.0.0-fabric.jar";
      sha512 = "d81fa97e11784c19d42f89c2f433831d007603dd7193cee45fa177e4a6a9c52b384b198586e04a0f7f63cd996fed713322578bde9a8db57e1188854ae5cbe584";
    };
    Krypton = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/kYAGItyj/krypton-0.3.0.jar";
      sha512 = "14233210283a76f3cf435a3b8ddbcbd65a858d2b1a10b88ff643c0a01486dfd2bf1843bd3456cd4fb86cbb3b06f2dea0c4e663b1976a48e96de16d3b5a707ec9";
    };
    Lithium = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/GiCfpS6V/lithium-fabric-0.24.5%2Bmc26.1.2.jar";
      sha512 = "5c31bd352d904d76be3b97d23d2d48580c7f9116c73fd3e435db5a780162e229e23f2c7e987ee37d7f65ca666cf7f812162627bd2e916ecb09d95803f582ad37";
    };
    ScalableLux = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/gYbHVCz8/ScalableLux-0.2.0%2Bfabric.2b63825-all.jar";
      sha512 = "48565a4d8a1cbd623f0044086d971f2c0cf1c40e1d0b6636a61d41512f4c1c1ddff35879d9dba24b088a670ee254e2d5842d13a30b6d76df23706fa94ea4a58b";
    };
    VMP = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/wnEe9KBa/versions/9f7J0dAp/vmp-fabric-mc26.1.2-0.2.0%2Bbeta.7.234-all.jar";
      sha512 = "24a0df2407893b1cfb55e27dc1c1fef008df53518d118aa3245924d37b642a27d7b6afde950fbf5d07c4111c44ac264d9ae56b8d8c6a9b55acdfb91ba0a15f16";
    };
    FabricAPI = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/yALY9gHM/fabric-api-0.151.0%2B26.1.2.jar";
      sha512 = "d087349842b962414ba89248f9ef7bc75f537848f4d783435de633ddae8924cd50fd9bffc606aae0f1c2c3ed9b4339623244e1fd34c6b9c17f977528d1303cdd";
    };
    Axiom = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/N6n5dqoA/versions/AfA2Emww/Axiom-5.4.2-for-MC26.1.jar";
      sha512 = "dac0681e5b377a8824153249559849eafb3a1e085b07c4586f10f3dd146a3aae935b998faef11c0bad1fbfb9e21d950ee21992af53790296bad8e7cc20b78a59";
    };
    Carpet = pkgs.fetchurl {
      url = "https://github.com/gnembon/fabric-carpet/releases/download/v26.1/fabric-carpet-26.1+v260402.jar";
      sha256 = "sha256:59bd225d12423a7d7a635ca0c94fa786f97ccebb116922b16d76072da4ee67e7";
    };
    CarpetTIS = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/jE0SjGuf/versions/gz6hRTtt/carpet-tis-addition-v1.80.0-mc26.1.2.jar";
      sha512 = "73c2189785667c78f52dc0d20f7a9915c8aa92eddfcd5dd9af7a5ec78b9a478cd331729949d71ca5529c10ae2b429535af4e021a88cf38eaab88cf11bb942143";
    };
  };

  # See: https://github.com/Infinidoge/nix-minecraft/issues/211
  minecraft-fabric-26_1_2 =
    pkgs.minecraftServers.fabric-26_1_2.override
    {jre_headless = pkgs.openjdk25_headless;};
in {
  settings.services.minecraft = {
    enable = true;
    servers = {
      survival = {
        enable = true;
        autoStart = true;
        package = minecraft-fabric-26_1_2;
        jvmOpts = "-Xms1G -Xmx2G";
        operators = players;
        whitelist = players;

        serverProperties = {
          difficulty = "hard";
          spawn-protection = 0;
          view-distance = 32;
          white-list = true;
        };

        symlinks.mods =
          pkgs.linkFarmFromDrvs "mods"
          (builtins.attrValues
            (pkgs.lib.filterAttrs (name: _: name != "Axiom") mods));
      };

      creative = {
        enable = true;
        autoStart = true;
        package = minecraft-fabric-26_1_2;
        jvmOpts = "-Xms1G -Xmx2G";
        operators = players;
        whitelist = players;

        serverProperties = {
          spawn-protection = 0;
          server-port = 25566;
          white-list = true;
        };

        symlinks.mods =
          pkgs.linkFarmFromDrvs "mods" (builtins.attrValues mods);
      };
    };
  };
}

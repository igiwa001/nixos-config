{pkgs, ...}: let
  players = {
    Dgtg = "8737ed5c-6d32-42d6-a11c-229303c7db6c";
    EzT_ = "cd3354a7-0661-435c-9944-b0cc2235685c";
  };
  mods = {
    Servux = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/zQhsx8KF/versions/1aOMm00f/servux-fabric-1.21.10-rc1-0.8.1.jar";
      sha512 = "a78fbdc85d16d433d3e573ca72f35fe99d8cc3c952406d9e7e25a30431e1026ecbbd11f9a507b2515668790881e354e346a48601073cc93398eceb285eb4dfd9";
    };
    FerriteCore = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar";
      sha512 = "131b82d1d366f0966435bfcb38c362d604d68ecf30c106d31a6261bfc868ca3a82425bb3faebaa2e5ea17d8eed5c92843810eb2df4790f2f8b1e6c1bdc9b7745";
    };
    Krypton = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/O9LmWYR7/krypton-0.2.10.jar";
      sha512 = "4dcd7228d1890ddfc78c99ff284b45f9cf40aae77ef6359308e26d06fa0d938365255696af4cc12d524c46c4886cdcd19268c165a2bf0a2835202fe857da5cab";
    };
    Lithium = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/L1sSIxFm/lithium-fabric-0.19.2%2Bmc1.21.9.jar";
      sha512 = "ecbebb18f82e589c1d24056b6cfe6a923acb8fea5dd038ed931568db7dc8dad1cfe4b42f9c0f7752ba45f39d4f0cab219deb61fcb54bcc7252c9fe34afc2549a";
    };
    ScalableLux = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/PV9KcrYQ/ScalableLux-0.1.6%2Bfabric.c25518a-all.jar";
      sha512 = "729515c1e75cf8d9cd704f12b3487ddb9664cf9928e7b85b12289c8fbbc7ed82d0211e1851375cbd5b385820b4fedbc3f617038fff5e30b302047b0937042ae7";
    };
    VMP = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/wnEe9KBa/versions/ppncuwIK/vmp-fabric-mc1.21.10-0.2.0%2Bbeta.7.215-all.jar";
      sha512 = "4c8026c7a2ee1cfd6b4113565543f87874e5da755640123561371f7ef0bf8d86e0ea4aadd5f96ee527b3903db5b3f01c00cb8052f72e802cee2dd4f32830df59";
    };
    FabricAPI = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/iHrvVvaM/fabric-api-0.134.0%2B1.21.9.jar";
      sha512 = "6f2c8d7aa311b90af2d80a4a9de18f22e3a19ebe22cf115278eabd3d397725bc706e98827c9eed20f9d751d4701e1da1cdf7258b90f77e65148a7a0133a1e336";
    };
    Axiom = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/N6n5dqoA/versions/TibxxJrx/Axiom-5.1.1-for-MC1.21.10.jar";
      sha512 = "7175d1c7ef4f5764a070e8d46076fc24d9005469a096d0a21a04ea45f96d7d47a3a1309a9627af3ef73b7584c1bbc56bc584a196914ba684762e4970609d65c0";
    };
  };
in {
  settings.services.minecraft = {
    enable = true;
    servers = {
      survival = {
        enable = true;
        autoStart = true;
        package = pkgs.minecraftServers.fabric-1_21_9;
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
        package = pkgs.minecraftServers.fabric-1_21_9;
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

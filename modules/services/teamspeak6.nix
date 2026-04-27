# Adapted from the nixpkgs teamspeak3 service
# https://github.com/NixOS/nixpkgs/blob/nixos-25.11/nixos/modules/services/networking/teamspeak3.nix
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.services.teamspeak6;
in {
  options.settings.services.teamspeak6 = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to run the Teamspeak3 voice communication server daemon.
      '';
    };

    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/teamspeak6-server";
      description = ''
        Directory to store TS6 database and other state/data files.
      '';
    };

    logPath = lib.mkOption {
      type = lib.types.path;
      default = "/var/log/teamspeak6-server/";
      description = ''
        Directory to store log files in.
      '';
    };

    voiceIP = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "[::]";
      description = ''
        IP on which the server instance will listen for incoming voice connections. Defaults to any IP.
      '';
    };

    defaultVoicePort = lib.mkOption {
      type = lib.types.port;
      default = 9987;
      description = ''
        Default UDP port for clients to connect to virtual servers - used for first virtual server, subsequent ones will open on incrementing port numbers by default.
      '';
    };

    fileTransferIP = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "[::]";
      description = ''
        IP on which the server instance will listen for incoming file transfer connections. Defaults to any IP.
      '';
    };

    fileTransferPort = lib.mkOption {
      type = lib.types.port;
      default = 30033;
      description = ''
        TCP port opened for file transfers.
      '';
    };

    queryIP = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "0.0.0.0";
      description = ''
        IP on which the server instance will listen for incoming ServerQuery connections. Defaults to any IP.
      '';
    };

    querySshPort = lib.mkOption {
      type = lib.types.port;
      default = 10022;
      description = ''
        TCP port opened for ServerQuery connections using the SSH protocol.
      '';
    };

    queryHttpPort = lib.mkOption {
      type = lib.types.port;
      default = 10080;
      description = ''
        TCP port opened for ServerQuery connections using the HTTP protocol.
      '';
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Open ports in the firewall for the TeamSpeak6 server.";
    };

    openFirewallServerQuery = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Open ports in the firewall for the TeamSpeak6 serverquery (administration) system. Requires openFirewall.";
    };
  };

  config = lib.mkIf cfg.enable {
    users = {
      users.teamspeak = {
        description = "Teamspeak6 voice communication server daemon";
        group = "teamspeak";
        uid = config.ids.uids.teamspeak;
        home = cfg.dataDir;
        createHome = true;
      };

      groups.teamspeak = {
        gid = config.ids.gids.teamspeak;
      };
    };

    systemd.tmpfiles.rules = [
      "d '${cfg.logPath}' - teamspeak teamspeak - -"
    ];

    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPorts =
        [
          cfg.fileTransferPort
        ]
        ++ (map (port: lib.mkIf cfg.openFirewallServerQuery port) [
          cfg.queryPort
          cfg.querySshPort
          cfg.queryHttpPort
        ]);
      # subsequent vServers will use the incremented voice port, let's just open the next 10
      allowedUDPPortRanges = [
        {
          from = cfg.defaultVoicePort;
          to = cfg.defaultVoicePort + 10;
        }
      ];
    };

    systemd.services.teamspeak6-server = {
      description = "Teamspeak6 voice communication server daemon";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        ExecStart = ''
          ${pkgs.teamspeak6-server}/bin/teamspeak6-server \
          --accept-license \
          --db-sql-path ${pkgs.teamspeak6-server}/lib/teamspeak6/sql \
          --log-path ${cfg.logPath} \
          --default-voice-port=${toString cfg.defaultVoicePort} \
          --filetransfer-port=${toString cfg.fileTransferPort} \
          --query-ssh-port=${toString cfg.querySshPort} \
          --query-http-port=${toString cfg.queryHttpPort} \
            ${lib.optionalString (cfg.voiceIP != null) "--voice-ip=${cfg.voiceIP}"} \
            ${lib.optionalString (cfg.fileTransferIP != null) "--filetransfer-ip=${cfg.fileTransferIP}"} \
            ${lib.optionalString (cfg.queryIP != null) "--query-ip=${cfg.queryIP}"} \
            ${lib.optionalString (cfg.queryIP != null) "--query-ssh-ip=${cfg.queryIP}"} \
            ${lib.optionalString (cfg.queryIP != null) "--query-http-ip=${cfg.queryIP}"} \
        '';
        WorkingDirectory = cfg.dataDir;
        User = "teamspeak";
        Group = "teamspeak";
        Restart = "on-failure";
      };
    };

    services.teamspeak3.enable = false;
  };
}

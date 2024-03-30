flake: { config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.quickHome;
  quick-home = flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
  settingsFile = pkgs.writeTextFile {
    name = "quickHome-settings.json";
    text = builtins.toJSON cfg.settings;
  };
in
{
  options.services.quickHome = {
    enable = mkEnableOption "Quick Home Service";

    port = mkOption {
      type = types.int;
      default = 3000;
      description = "Port on which Quick Home runs.";
    };

    host = mkOption {
      type = types.str;
      default = "localhost";
      description = "Host for Quick Home.";
    };

    settings = mkOption {
      type = types.attrs;
      default = {};
      description = "Configuration settings for Quick Home.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.hello ];

    systemd.services.quickHome = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      environment = {
        NODE_ENV = "production";
        NITRO_PORT = toString cfg.port;
        NITRO_HOST = cfg.host;
        QUICK_HOME_SETTINGS = "${settingsFile}";
      };
      serviceConfig = {
        ExecStart = "${quick-home}/bin/quick-home";
        Restart = "always";
        DynamicUser = true;
        StateDirectory = "quickHome";
      };
    };
  };
}

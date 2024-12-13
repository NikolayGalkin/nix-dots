{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkPackageOption;
  cfg = config.${namespace}.services.aerospace;

  # format = pkgs.formats.toml { };
  # config-file = format.generate "aerospace.toml" cfg.settings;
  config-file = builtins.readFile ./aerospace.toml;

in
{
  options.${namespace} = {
    services.aerospace = {
      enable = mkEnableOption "AeroSpace window manager";
      package = mkPackageOption pkgs "aerospace" { };
    };
  };

  config = (
    lib.mkIf (cfg.enable) {
      environment.systemPackages = [ cfg.package ];

      # home.file.".config/aerospace/aerospace.toml".text = config-file;

      launchd.user.agents.aerospace = {
        command =
          "${cfg.package}/Applications/AeroSpace.app/Contents/MacOS/AeroSpace"
          + " --config-path ${config-file}";
        serviceConfig = {
          KeepAlive = true;
          RunAtLoad = true;
        };
      };
    }
  );
}

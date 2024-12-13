{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkPackageOption;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.programs.graphical.apps.aerospace;
  config-file = builtins.readFile ./aerospace.toml;
in
{
  options.${namespace}.programs.graphical.apps.aerospace = {
    enable = mkBoolOpt false "Whether or not to enable Aerospace.";
    package = mkPackageOption pkgs "aerospace" { };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file.".config/aerospace/aerospace.toml".text = config-file;

    # TODO: Add launchd agent

    # launchd = {
    #   enable = true;
    # };
    #
    # launchd.agents.aerospace = {
    #   enable = true;
    #   config = {
    #     # Program = "${cfg.package}/Applications/AeroSpace.app/Contents/MacOS/applet";
    #     ProgramArguments = [ "${cfg.package}/Applications/AeroSpace.app/Contents/MacOS/AeroSpace" ];
    #     serviceConfig = {
    #       KeepAlive = true;
    #       RunAtLoad = true;
    #     };
    #   };
    # };
  };
}

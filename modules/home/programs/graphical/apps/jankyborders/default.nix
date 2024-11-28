{ config, lib, pkgs, namespace, ... }:
let
  inherit (lib) mkIf mkPackageOption;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.apps.jankyborders;
  # config-file = builtins.readFile ./bordersrc;

  # TODO: move config to separate file
  settings = {
    style = "round";
    width = "10";
    hidpi = "on";
    ax_focus = "on";
    active_color = "0xFF000000";
    inactive_color = "0x00FF0000";
  };
in
{
  options.${namespace}.programs.graphical.apps.jankyborders = {
    enable = mkBoolOpt false "Whether or not to enable JankyBorders.";
    package = mkPackageOption pkgs "jankyborders" { };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    # home.file.".config/borders/bordersrc".text = config-file;


    launchd = {
      enable = true;
    };

    launchd.agents.jankyborders = {
      enable = true;
      config = {
        Program = "${cfg.package}/bin/borders";
        ProgramArguments = [
          "${cfg.package}/bin/borders"
          "width=${settings.width}"
          "style=${settings.style}"
          "hidpi=${settings.hidpi}"
          "active_color=${settings.active_color}"
          "inactive_color=${settings.inactive_color}"
        ];
        serviceConfig = {
          KeepAlive = true;
          RunAtLoad = true;
        };
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  cfg = config.${namespace}.programs.graphical.apps.zoom-us;
in
{
  options.${namespace}.programs.graphical.apps.zoom-us = {
    enable = mkBoolOpt false "Whether or not to enable Zoom.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ zoom-us ];
  };
}

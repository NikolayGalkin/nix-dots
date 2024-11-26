{ config, lib, pkgs, namespace, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  cfg = config.${namespace}.programs.graphical.browsers.opera;
in
{
  options.${namespace}.programs.graphical.browsers.opera = {
    enable = mkBoolOpt false "Whether or not to enable Opera.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ opera ];
  };
}

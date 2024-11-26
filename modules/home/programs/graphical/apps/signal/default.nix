{ config, lib, pkgs, namespace, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  cfg = config.${namespace}.programs.graphical.apps.signal;
in
{
  options.${namespace}.programs.graphical.apps.signal = {
    enable = mkBoolOpt false "Whether or not to enable Signal.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ signal-desktop ];
  };
}

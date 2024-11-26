{ config, lib, pkgs, namespace, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  cfg = config.${namespace}.programs.graphical.apps.telegram;
in
{
  options.${namespace}.programs.graphical.apps.telegram = {
    enable = mkBoolOpt false "Whether or not to enable Telegram.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ telegram-desktop ];
  };
}

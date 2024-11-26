{ config, lib, namespace, ... }:
let
  inherit (lib) types mkIf;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.security.pam;
in
{
  options.${namespace}.security.pam = {
    enable = mkBoolOpt true "Whether or not to manage pam.";
  };

  config = mkIf cfg.enable {
    security.pam.enableSudoTouchIdAuth = true;
  };
}

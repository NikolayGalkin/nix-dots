{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

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

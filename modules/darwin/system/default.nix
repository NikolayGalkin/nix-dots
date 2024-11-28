{ config, lib, namespace, ... }:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.system;
in
{
  options.${namespace}.system = {
    enable = mkEnableOption "MacOS System";
  };

  config = mkIf cfg.enable {
    system = {
      stateVersion = 5;

      activationScripts.postUserActivation.text = ''
        # activateSettings -u will reload the settings from the database and apply them to the current session,
        # so we do not need to logout and login again to make the changes take effect.
        /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      '';
    };
  };
}

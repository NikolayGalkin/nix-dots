{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.${namespace}.nix;
in
{
  config = lib.mkIf cfg.enable {
    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
        interval = {
          Day = 7;
          Hour = 14;
        };
      };
    };
  };
}

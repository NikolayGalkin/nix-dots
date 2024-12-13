{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.services.sketchybar;
in
{
  options.${namespace}.services.sketchybar = {
    enable = mkEnableOption "Enable Sketchybar";
  };

  config = mkIf cfg.enable {
    services.sketchybar = {
      enable = true;
    };
  };
}

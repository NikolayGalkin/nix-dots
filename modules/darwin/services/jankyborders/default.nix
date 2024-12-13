{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.jankyborders;

in
{
  options.${namespace}.services.jankyborders = {
    enable = mkBoolOpt false "Whether or not to enable JankyBorders.";
  };

  config = mkIf cfg.enable {
    services.jankyborders = {
      enable = true;
      hidpi = true;
      width = 15.0;
      active_color = "0xffDDB6F2";
      inactive_color = "0x9992B3F5";
      # active_color = "gradient(top_left=0xffDDB6F2,bottom_right=0xff96CDFB)";
      # inactive_color = "gradient(top_right=0x9992B3F5,bottom_left=0x9992B3F5)";
    };
  };
}

{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.theme;
in
{
  options.${namespace}.theme = {
    enable = mkBoolOpt false "Whether or not to enable catppuccin theme.";
  };

  config = mkIf cfg.enable {
    catppuccin = {
      enable = true;
      accent = "teal";
    };
  };
}

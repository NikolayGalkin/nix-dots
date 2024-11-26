{ config, lib, namespace, ... }:
let
  inherit (lib.${namespace}) mkBoolOpt;
  cfg = config.${namespace}.documentation;
in
{
  options.${namespace}.documentation = {
    enable = mkBoolOpt false "Whether or not to manage documentation configuration.";
  };

  config = {
    documentation = {
      doc.enable = cfg.enable;
      info.enable = cfg.enable;
      man.enable = cfg.enable;
    };
  };
}

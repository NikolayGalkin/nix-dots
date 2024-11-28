{ config, lib, namespace, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.tools.homebrew;
in
{
  options.${namespace}.tools.homebrew = {
    enable = mkBoolOpt false "Whether or not to manage Homebrew Programs.";
  };

  config = mkIf cfg.enable {
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        upgrade = true;
        cleanup = "zap";
      };

      global = {
        autoUpdate = true;
        brewfile = true;
        lockfiles = true;
      };
    };
  };
}

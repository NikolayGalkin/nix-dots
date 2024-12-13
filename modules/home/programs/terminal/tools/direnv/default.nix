{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.programs.terminal.tools.direnv;
in
{
  options.${namespace}.programs.terminal.tools.direnv = {
    enable = mkEnableOption "Whether or not to enable direnv.";
    silent = mkEnableOption "Whether or not to suppress direnv output.";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv = enabled;
      enableZshIntegration = true;
      silent = cfg.silent;
    };
  };
}

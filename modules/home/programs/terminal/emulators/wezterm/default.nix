{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.emulators.wezterm;
in
{
  options.${namespace}.programs.terminal.emulators.wezterm = {
    enable = mkBoolOpt false "Whether or not to enable wezterm.";
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = builtins.readFile ./wezterm.lua;
    };
  };
}

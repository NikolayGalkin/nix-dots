{
  config,
  lib,
  system,
  namespace,
  inputs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  inherit (inputs) gnvim;
  cfg = config.${namespace}.programs.terminal.editors.neovim;
in
{
  options.${namespace}.programs.terminal.editors.neovim = {
    enable = mkBoolOpt false "Whether or not to manage documentation configuration.";
  };

  config = mkIf cfg.enable {
    home = {
      packages = [
        gnvim.packages.${system}.default
      ];

      shellAliases = {
        v = "nvim";
      };

      sessionVariables = {
        MANPAGER = "nvim +Man!";
      };
    };
  };
}

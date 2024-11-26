{ config, lib, pkgs, namespace, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  cfg = config.${namespace}.programs.terminal.editors.neovim;
in
{
  options.${namespace}.programs.terminal.editors.neovim = {
    enable = mkBoolOpt false "Whether or not to manage documentation configuration.";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withRuby = false;
      defaultEditor = true;
    };

    home.packages = with pkgs; [
      wget
      nodejs_22
      tree-sitter
      lua51Packages.jsregexp
      lua51Packages.lua
      lua54Packages.luarocks
    ];

    home.shellAliases = {
      v = "nvim";
    };

    home.sessionVariables = {
      MANPAGER = "nvim +Man!";
    };
  };
}

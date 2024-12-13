{ lib, namespace, ... }:
let
  inherit (lib.${namespace}) enabled;
in
{
  home.stateVersion = "24.11";

  personal = {
    user = {
      enable = true;
      name = "galkin";
      email = "mykola.halkin@nixs.com";
      full-name = "Mykola Halkin";
    };

    programs = {
      graphical = {
        apps = {
          aerospace = enabled;
          zoom-us = enabled;
          signal = enabled;
          telegram = enabled;
        };
      };

      terminal = {
        emulators = {
          wezterm = enabled;
        };
        editors = {
          neovim = enabled;
        };
        shell = {
          zsh = enabled;
        };
        tools = {
          bat = enabled;
          eza = enabled;
          fzf = enabled;
          zoxide = enabled;
          fd = enabled;
          yazi = enabled;
          lazygit = enabled;
          jq = enabled;
          git = enabled;
          ripgrep = enabled;
          starship = enabled;
          direnv = {
            enable = true;
            # silent = false;
          };
        };
      };
    };
  };
}

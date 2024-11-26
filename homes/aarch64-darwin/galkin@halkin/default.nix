{ lib, namespace, ... }:
let
  inherit (lib.${namespace}) enabled disabled;
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
        browsers = {
          opera = disabled; # TODO: learn how to unzip dmg files. Look at `undmg`
        };
        apps = {
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

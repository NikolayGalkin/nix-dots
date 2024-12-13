{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.system.fonts;
in
{
  options.${namespace}.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts =
      with pkgs;
      mkOpt (listOf package) [
        noto-fonts-color-emoji
        twemoji-color-font
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
      ] "Custom font packages to install.";
    default = mkOpt types.str "JetBrainsMono Nerd Font" "Default font name";
  };

  config = mkIf cfg.enable {
    fonts = {
      packages = [ ] ++ cfg.fonts;
    };

    system = {
      defaults = {
        NSGlobalDomain = {
          AppleFontSmoothing = 1;
        };
      };
    };

    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };
  };
}

{ config, lib, namespace, ... }:
let
  inherit (lib) types mkIf mkMerge;
  inherit (lib.${namespace}) mkOpt enabled;

  home-directory = "/Users/${cfg.name}";

  cfg = config.${namespace}.user;
in
{
  options.${namespace}.user = {
    enable = mkOpt types.bool false "Whether to configure the user account.";
    name = mkOpt types.str "galkin" "The user account.";
    email = mkOpt types.str "mr.galkin@gmail.com" "The email of the user.";
    full-name = mkOpt types.str "Mykola Halkin" "The full name of the user.";
    home = mkOpt (types.nullOr types.str) home-directory "The home directory of the user.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
          assertion = cfg.name != null;
          message = "${namespace}.user.name must be set";
        }
        {
          assertion = cfg.home != null;
          message = "${namespace}.user.home must be set";
        }
      ];

      home = {
        homeDirectory = cfg.home;
        username = cfg.name;

        shellAliases = {
          ".." = "cd ..";
          "..." = "cd ../..";
        };
      };

      programs.home-manager = enabled;
    }
  ]);
}

{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) types;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.user;
in
{
  options.${namespace}.user = {
    name = mkOpt types.str "galkin" "The user account.";
    email = mkOpt types.str "mr.galkin@gmail.com" "The email of the user";
    full-name = mkOpt types.str "Mykola Halkin" "The full name of the user";
  };

  config = {
    users.users.${cfg.name} = {
      shell = pkgs.zsh;
    };
  };
}

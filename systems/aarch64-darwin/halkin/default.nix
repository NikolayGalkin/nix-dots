{ lib, namespace, ... }:
let
  inherit (lib.${namespace}) enabled;
in
{
  system.stateVersion = 5;

  personal = {
    documentation.enable = false;

    user = {
      name = "galkin";
      email = "mr.galkin@gmail.com";
      full-name = "Mykola Halkin";
    };

    security = {
      pam = enabled;
    };

    system = {
      fonts = enabled;
    };
  };

  nix.settings = {
    cores = 16;
    max-jobs = 8;
  };
}

{ lib, namespace, ... }:
let
  inherit (lib.${namespace}) enabled disabled;
in
{
  system.stateVersion = 5;

  personal = {
    documentation = disabled;

    user = {
      name = "galkin";
      email = "mr.galkin@gmail.com";
      full-name = "Mykola Halkin";
    };

    security = {
      pam = enabled;
    };

    system = {
      enable = true;
      interface = enabled;
      fonts = enabled;
      input = enabled;
    };

    services = {
      aerospace = disabled;
      jankyborders = enabled;
      sketchybar = disabled;
    };

    tools.homebrew = enabled;
  };

  homebrew = {
    casks = [
      "microsoft-office"
      "virtualbox"
      "clickup"
    ];
  };
}

{ mkShell, pkgs, ... }:

mkShell {
  packages = with pkgs; [ hello ];
}

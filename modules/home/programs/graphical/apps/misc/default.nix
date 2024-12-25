{ pkgs, ... }:
{
  home.packages = with pkgs; [
    numi
    slides
    imagemagick
  ];
}

{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs:
    let
      inherit (inputs) snowfall;

      lib = snowfall.mkLib {
        inherit inputs;
        src = ./.;

        snowfall = {
          meta = {
            name = "halkin";
            title = "Halkin Nix";
          };

          namespace = "personal";
        };
      };
    in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
      };

      overlays = [ ];

      systems = {
        darwin = [ ];
        modules = [ ];
      };

      homes.modules = with inputs; [
        catppuccin.homeManagerModules.catppuccin
      ];

    };
}

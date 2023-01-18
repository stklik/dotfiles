{
  description = "Stefan's darwin system";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-22.05-darwin";
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";


    # Other sources
    comma = { url = github:Shopify/comma; flake = false; };
    
  };

  outputs = { self, darwin, nixpkgs, home-manager, ... }@inputs: 
  let 

    inherit (darwin.lib) darwinSystem;
    inherit (inputs.nixpkgs.lib) attrValues makeOverridable optionalAttrs singleton;

  in 
  {
    darwinConfigurations."Stefans-MacBook" = darwinSystem {
      system = "x86_64-darwin";
      modules = [ 
        # Main `nix-darwin` config
        ./configuration.nix 
        # `home-manager` module
        home-manager.darwinModules.home-manager
        {
          # nixpkgs = nixpkgsConfig;
          # `home-manager` config
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.stefan = import ./home.nix;
        }
      ];
    };
  };
}

{
  description = "My NixOS Flake Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/b79ce4c43f9117b2912e7dbc68ccae4539259dda";
    nur.url = "github:nix-community/NUR";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #Color Themeing
    stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";

    # Apple Fonts
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      apple-fonts,
      spicetify-nix,
      nur,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit apple-fonts;
    in
    {
      nixosConfigurations = {
        blind-faith = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs apple-fonts };
          modules = [
            ./nixos/configuration.nix 
            nur.nixosModules.nur       
            { nixpkgs.overlays = [ nur.overlay ]; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users.hushh = {
                imports = [
                  ./home-manager/home.nix
                  stylix.homeManagerModules.stylix
                  spicetify-nix.homeManagerModules.default
                ];
              };
            }
          ];
        };
      };

      #nixosConfigurations = {
      #  blind-faith = nixpkgs.lib.nixosSystem {
      #    specialArgs = {
      #      inherit inputs outputs apple-fonts;
      #    };
      #    modules = [
      #      ./nixos/configuration.nix 
      #      nur.nixosModules.nur       
      #      { nixpkgs.overlays = [ nur.overlay ]; }
      #      home-manager.nixosModules.home-manager
      #      {
      #        home-manager.useGlobalPkgs = true;
      #      }
      #    ];
      #  };
      #};
#
      #homeConfigurations = {
      #  "hushh@blind-faith" = home-manager.lib.homeManagerConfiguration {
      #    pkgs = nixpkgs.legacyPackages.x86_64-linux;
      #    extraSpecialArgs = {
      #      inherit inputs outputs spicetify-nix;
      #    };
      #    modules = [
      #      ./home-manager/home.nix
      #      stylix.homeManagerModules.stylix
      #      spicetify-nix.homeManagerModules.default
      #      nur.nixosModules.nur       
      #      { nixpkgs.overlays = [ nur.overlay ]; }
      #    ];
      #  };
      #};
    };
}

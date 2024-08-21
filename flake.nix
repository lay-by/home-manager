{
  description = "My NixOS Flake Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
          specialArgs = {
            inherit inputs outputs apple-fonts;
          };
          modules = [
            inputs.nur.nixosModules.nur
            ./nixos/configuration.nix 
          ];
        };
      };

      homeConfigurations = {
        "hushh@blind-faith" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs spicetify-nix;
          };
          modules = [
            ./home-manager/home.nix
            stylix.homeManagerModules.stylix
            spicetify-nix.homeManagerModules.default
          ];
        };
      };
    };
}

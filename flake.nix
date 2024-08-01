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

    # Apple Fonts
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      apple-fonts,
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
          modules = [ ./nixos/configuration.nix ];
        };
      };

      homeConfigurations = {
        "hushh@blind-faith" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./home-manager/home.nix
            stylix.homeManagerModules.stylix
          ];
        };
      };
    };
}

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
    #apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    #apple-fonts.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    ucodenix.url = "github:e-tho/ucodenix";

    nvidia-patch.url = "github:icewind1991/nvidia-patch-nixos";  
    nvidia-patch.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: {
    nixosConfigurations = {
      blind-faith = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/configuration.nix
          inputs.nur.modules.nixos.default
          { nixpkgs.overlays = [ inputs.nur.overlays.default inputs.nvidia-patch.overlays.default ]; }
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.hushh = {
              imports = [
                ./home-manager/home.nix
                inputs.stylix.homeManagerModules.stylix
                inputs.spicetify-nix.homeManagerModules.default
              ];
            };  
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
        ];
      };
    };
  };
}

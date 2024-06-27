{
  description = "Your new nix config";

  inputs = {

    # Core inputs
    # =====================================================
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ssh-keys = {
      url = "https://github.com/lsrhazaki.keys";
      flake = false;
    };
  };
   
  # Conf Inputs
  # ===================================================== 

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";

    overlays = import ./overlays {inherit inputs;};

    nixosModules = import ./modules/nixos;

  in {
    nixosConfigurations = {
      nixsaiga = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
        ./nixos/configuration.nix
       ];
      };
    };

    homeConfigurations = {
      "hazaki@nixsaiga" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home/home.nix];
      };
    };
  };
}

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      specialArgs = { host-config = { username = "luis"; }; };
    in {

      nixosConfigurations.cloud-nix = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/cloud-nix/configuration.nix
          home-manager.nixosModules.home-manager
          {
            # home-manager.useGlobalPkgs = true;
            # home-manager.useUserPackages = true;

            # TODO replace ryan with your own username
            home-manager.users.luis = import ./hosts/cloud-nix/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
}

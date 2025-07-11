{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      specialArgs = {
        username = "luis";
        host-config = { username = "luis"; };

        inherit system inputs;
      };

      # Used in standalone home manager
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

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

      nixosConfigurations.vm-nix = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/vm-nix/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.luis = import ./hosts/vm-nix/home.nix;
            home-manager.backupFileExtension = ".nix-bak";
          }
        ];
      };

      nixosConfigurations.ackerman = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/ackerman/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.luis = import ./hosts/ackerman/home.nix;
            home-manager.backupFileExtension = ".nix-bak";
          }
        ];
      };

      homeConfigurations.luis-addvolt-dell = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./hosts/luis-addvolt-dell/home.nix ];
      };
      };
}

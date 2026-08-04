{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      specialArgs = {
        username = "luis";
        host-config = {
          username = "luis";
        };

        inherit system inputs pkgs-unstable nixos-hardware;
      };

      # Used in standalone home manager
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    in
    {

      nixosConfigurations.cloud-nix = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/cloud-nix/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            # home-manager.useUserPackages = true;

            # TODO replace ryan with your own username
            home-manager.users.luis = import ./hosts/cloud-nix/home.nix;

            home-manager.extraSpecialArgs = specialArgs;
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
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.useGlobalPkgs = true;
            home-manager.users.luis = import ./hosts/ackerman/home.nix;
            home-manager.backupFileExtension = ".nix-bak";
          }
        ];
      };

      nixosConfigurations.trafalgar = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/trafalgar/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.useGlobalPkgs = true;
            home-manager.users.luis = import ./hosts/trafalgar/home.nix;
            home-manager.backupFileExtension = ".nix-bak";
          }
        ];
      };

      nixosConfigurations.usopp = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/usopp/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.luis = import ./hosts/usopp/home.nix;
            home-manager.backupFileExtension = ".nix-bak";
          }
        ];
      };

      homeConfigurations.luis-addvolt-dell = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit pkgs-unstable; };

        modules = [ ./hosts/luis-addvolt-dell/home.nix ];
      };
      homeConfigurations.work-dell = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit pkgs-unstable; };

        modules = [ ./hosts/work-dell/home.nix ];
      };
    };
}

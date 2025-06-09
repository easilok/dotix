{
  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
      nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
        system = "x86_64-linux";
        specialArgs = {
            host-config = {
                username = "luis";
            };
        };
  in
  {

    nixosConfigurations.cloud-nix = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [ ./hosts/cloud-nix/configuration.nix ];
    };
  };
}

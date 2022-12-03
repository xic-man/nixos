{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nur.url = "github:nix-community/NUR/master";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, nur, ... }: {
    nixosConfigurations.xic-framework = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nur.nixosModules.nur
        home-manager.nixosModules.home-manager        

        ./configuration.nix
        ./hardware-configuration.nix
        ./xic.nix
        nixos-hardware.nixosModules.framework-12th-gen-intel
      ];
    };
  };
}

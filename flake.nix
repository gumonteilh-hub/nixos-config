{
  description = "NixOs + Hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    quickshell,
    home-manager,
    nixpkgs-unstable,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      perso = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs pkgsUnstable;};
        modules = [
          ./configuration.nix
          ./hosts/perso/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gmonteilhet = import ./home/home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs pkgsUnstable quickshell;
              profile = "perso";
            };
          }
        ];
      };

      work = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs pkgsUnstable quickshell;};
        modules = [
          ./configuration.nix
          ./hosts/work/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gmonteilhet = import ./home/home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs pkgsUnstable;
              profile = "work";
            };
          }
        ];
      };
    };
  };
}

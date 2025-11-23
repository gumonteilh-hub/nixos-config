{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-perso";
  programs.steam.enable = true;
}

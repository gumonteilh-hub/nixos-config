{pkgs, ...}: {
  home.packages = with pkgs; [
    lutris
    stremio
  ];
}

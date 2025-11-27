{ pkgs, ... }:

let
  youtubePwa = pkgs.makeDesktopItem {
    name = "youtube-pwa";
    desktopName = "YouTube";
    genericName = "Video Player";
    exec = "chromium --app=https://www.youtube.com";
    icon = "youtube";
    categories = [ "AudioVideo" ];
  };
  youtubeMusicPwa= pkgs.makeDesktopItem {
    name = "youtube-music-pwa";
    desktopName = "YouTube Musique";
    genericName = "Audio Player";
    exec = "chromium --app=https://music.youtube.com";
    icon = "youtube-music";
    categories = [ "Audio" ];
  };
in
{
  home.packages = [
    youtubePwa
    youtubeMusicPwa
  ];
}

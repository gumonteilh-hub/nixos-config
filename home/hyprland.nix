{pkgs, lib, ...}: {
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    NIXOS_OZONE_WL = "1";
  };

  home.packages = with pkgs; [
    libsForQt5.qt5ct
    qt6ct
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    settings = {
      env = [
        "XCURSOR_THEME,Bibata-Modern-Ice"
        "XCURSOR_SIZE,24"
      ];

      monitor = lib.mkDefault [ ",preferred,auto,1"];

      "$terminal" = "ghostty";
      "$fileManager" = "dolphin";
      "$menu" = "uwsm app -- rofi -show drun";

      exec-once = [
        "hyprpaper"
        "~/.config/hypr/scripts/wallpaper_random.sh"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 1;

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        allow_tearing = true;
        layout = "dwindle";
      };

      decoration = {
        rounding = 2;
        active_opacity = 1.0;
        inactive_opacity = 0.95;

        blur = {
          enabled = true;
          size = 8;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = "snappy, 0.05, 0.9, 0.1, 1.02";

        animation = [
          "windowsIn, 1, 3, snappy, popin 60%"
          "windowsOut, 1, 2, snappy, popin 60%"
          "windowsMove, 1, 3, snappy"
          "specialWorkspace, 1, 3, snappy, slidevert"
          "fade, 0, 1, default"
          "workspaces, 1, 3, snappy, slide"
          "border, 1, 1, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        focus_on_activate = true;
      };

      input = {
        kb_layout = "fr";
        numlock_by_default = true;
      };

      cursor = {
        hide_on_key_press = true;
      };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, W, killactive,"
        "$mainMod, F, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, SPACE, exec, $menu"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, code:10, workspace, 1"
        "$mainMod, code:11, workspace, 2"
        "$mainMod, code:12, workspace, 3"
        "$mainMod, code:13, workspace, 4"
        "$mainMod, code:14, workspace, 5"
        "$mainMod, code:15, workspace, 6"
        "$mainMod, code:16, workspace, 7"
        "$mainMod, code:17, workspace, 8"
        "$mainMod, code:18, workspace, 9"
        "$mainMod, code:19, workspace, 10"

        "$mainMod SHIFT, code:10, movetoworkspace, 1"
        "$mainMod SHIFT, code:11, movetoworkspace, 2"
        "$mainMod SHIFT, code:12, movetoworkspace, 3"
        "$mainMod SHIFT, code:13, movetoworkspace, 4"
        "$mainMod SHIFT, code:14, movetoworkspace, 5"
        "$mainMod SHIFT, code:15, movetoworkspace, 6"
        "$mainMod SHIFT, code:16, movetoworkspace, 7"
        "$mainMod SHIFT, code:17, movetoworkspace, 8"
        "$mainMod SHIFT, code:18, movetoworkspace, 9"
        "$mainMod SHIFT, code:19, movetoworkspace, 10"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };

  home.file.".config/hypr/scripts/wallpaper_random.sh" = {
    executable = true;
    text = ''
      #!/bin/sh

      sleep 1

      WALLPAPER_DIR="$HOME/Images/Wallpapers/"
      CURRENT_WALL=$(hyprctl hyprpaper listloaded)

      WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

      hyprctl hyprpaper reload ,"$WALLPAPER"
    '';
  };

  programs.waybar = {
    enable = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = ["/home/gmonteilhet/Images/Wallpapers/caraibes.png"];
      wallpaper = [",/home/gmonteilhet/Images/Wallpapers/caraibes.png"];
    };
  };
}

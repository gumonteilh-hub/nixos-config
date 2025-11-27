{
  pkgs,
  profile,
  lib,
  pkgsUnstable,
  quickshell,
  ...
}: let
  isWork = profile == "work";
  isPerso = profile == "perso";
in {
  imports =
    [
      ./hyprland.nix
      ./waybar.nix
      ./pwa.nix
    ]
    ++ lib.optionals isWork [./work.nix]
    ++ lib.optionals isPerso [./perso.nix];

  home.username = "gmonteilhet";
  home.homeDirectory = "/home/gmonteilhet";
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    zed-editor
    quickshell.packages.${pkgs.system}.default
    kora-icon-theme
  ];

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  gtk = {
    enable = true;
    iconTheme = {
      name= "kora";
      package = pkgs.kora-icon-theme;
    };
  };

  programs.git = {
    enable = true;
    userName = "gumonteilh";
    userEmail = "monteilhetguillaume@gmail.com";
    extraConfig  = {
      push = {
        autoSetupRemote = true;
      };
    };
  };

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      window-decoration = false;
      confirm-close-surface = false;
      resize-overlay = "never";
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting #
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };

  programs.btop = {
    enable = true;
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    extraConfig = {
      modi = "drun";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
      sidebar-mode = true;
      click-to-exit = true;
      click-to-select = true;
      matching = "fuzzy";
      sort = true;
      sorting-method = "fzf";
      display-drun = "   Apps ";
    };
    theme = "squared-everforest";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      gcc
      git
      ripgrep
      lazygit
      nodejs_24
      pkgsUnstable.rustc
      pkgsUnstable.cargo
      pkgsUnstable.rust-analyzer
      pkgsUnstable.clippy
      pkgsUnstable.rustfmt
      nil
      lua-language-server
      nodePackages.typescript-language-server
      jdt-language-server
      biome
      alejandra
    ];
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_github";
      };
    };
  };

  home.stateVersion = "25.05";
}

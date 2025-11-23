{pkgs, ...}: {
  # gestion boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = ["btusb.enable_autosuspend=n" ];

  # gestion network
  networking.networkmanager.enable = true;

  # gestion hardware
  hardware.bluetooth = {
	  enable = true;
	  powerOnBoot = true;
	  settings = {
		  General = {
			  FastConnectable = true;
			  Experimental = true;
		  };
	  };
  };
  hardware.graphics.enable = true;
  hardware.enableAllFirmware = true;


  # gestion localisation
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  console.keyMap = "fr";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # gestion user
  users.users.gmonteilhet = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Monteilhet Guillaume";
    extraGroups = ["networkmanager" "wheel"];
    packages = [];
  };

  # gestion displayManager
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    autoLogin = {
      enable = true;
      user = "gmonteilhet";
    };
    defaultSession = "hyprland-uwsm";
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # gestion packages
  programs.fish.enable = true;
  environment.systemPackages = with pkgs; [
    chromium
    nh
    bluetui
    usbutils
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/gmonteilhet/nixos-config"; 
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";
  };

  # gestion de l'audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # gestion firewall
  networking.firewall.enable = true;
  networking.firewall.allowPing = false;

  # gestion nix
  nixpkgs.config.allowUnfree = true;
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "25.05";
}

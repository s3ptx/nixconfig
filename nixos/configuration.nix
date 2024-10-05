
# $$\                       $$\       $$\           
# $$ |                      $$ |      $$ |          
# $$$$$$$\   $$$$$$\   $$$$$$$ | $$$$$$$ | $$$$$$\  
# $$  __$$\ $$  __$$\ $$  __$$ |$$  __$$ |$$  __$$\ 
# $$ |  $$ |$$$$$$$$ |$$ /  $$ |$$ /  $$ |$$$$$$$$ |
# $$ |  $$ |$$   ____|$$ |  $$ |$$ |  $$ |$$   ____|
# $$ |  $$ |\$$$$$$$\ \$$$$$$$ |\$$$$$$$ |\$$$$$$$\ 
# \__|  \__| \_______| \_______| \_______| \_______|
# configuration.nix

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # use GRUB 2 Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  
  # Hostname
  networking.hostName = "theBeast";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

environment.systemPackages = with pkgs;
      [
	speedtest-cli
    curl
  	gitFull
	curl
	wget
	htop
	cmus
	gcc
	nmap
	fuse
	p7zip
    ffmpeg
    fastfetch
	alacritty
  	gimp
  	thunderbird
  	handbrake
  	audacity
  	chromium
  	flameshot
  	audacious
  	discord
  	wireshark
  	qbittorrent
  	vscode
  	spotify
  	wine
  	lutris
     ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Budgie Desktop environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.budgie.enable = true;

  # Exclude some Budgie applications
  environment.budgie.excludePackages = with pkgs; [
  mate.mate-terminal
  vlc
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

 # set user
 users.users = {
    hedde = {
      initialPassword = "hedde";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = ["wheel, networkmanager, audio, docker,"];
    };
  };

  # virtmanager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # user docker
  users.extraGroups.docker.members = ["hedde"];

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "hedde";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # docker
  virtualisation.docker.enable = true;  
  virtualisation.docker.rootless = {
   enable = true;
   setSocketVariable = true;
  };

  # openssh
  services.openssh = {
   enable = true;
   settings.PasswordAuthentication = false;
   settings.KbdInteractiveAuthentication = false;

  };
 
  system.stateVersion = "24.05"; # Did you read the comment?

}



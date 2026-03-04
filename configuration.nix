# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, stablePkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.hostName = "laptop-buddy";
  networking.extraHosts = ''
  	192.168.1.153 server
  '';

  time.timeZone = "America/Denver";
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  services.udev.packages = [ pkgs.openocd ];
  users.users.elWapo = {
    isNormalUser = true;
    extraGroups = [ "wheel"  "networkmanager" "dialout" "plugdev"]; # Enable ‘sudo’ for the user.
  };
  users.groups.plugdev = {};

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = (with pkgs; [
    neovim
    wget
    git 
    ghostty
    obsidian
    go
    gopls
    gcc
    nodejs_24
    llvmPackages_20.clang-tools
    gnumake
    python315
    uv
    inetutils 
  ]) ++ (with stablePkgs; [
    kdePackages.okular
    gnome.gvfs
  ]);
  fonts.packages = with pkgs; [
   fira-code
   fira-code-symbols
  ];
  system.stateVersion = "25.11";


  specialisation  = {

    hardware.configuration = {
      programs.dconf.enable = true;
      system.nixos.tags = [ "hardware" ];
      services.xserver.enable = true;
      services.desktopManager.gnome.enable = true;

      services.xserver.xkb.layout = "us";
      services.xserver.videoDrivers = [ "modesetting" ];
      environment.systemPackages = with pkgs; [
        kicad
      ];
      environment.sessionVariables.XDG_DATA_DIRS = [
        "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
        "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      ];
    };

    software.configuration = {
      system.nixos.tags = [ "software" ];
      programs.hyprland.enable = true;
      programs.regreet.enable = true;
      environment.systemPackages = with pkgs; [
      	kitty
	hyprlauncher
	hyprpaper
	hypridle
	waybar
	wofi
	kdePackages.dolphin
      ];
    };
  };
}

# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

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

  environment.systemPackages = with pkgs; [
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
    kdePackages.okular
    gnumake
    python315
    uv
    inetutils 
  ];
  fonts.packages = with pkgs; [
   fira-code
   fira-code-symbols
  ];
  system.stateVersion = "25.11";


  specialisation  = {
    hardware.configuration = {
      system.nixos.tags = [ "hardware" ];
      services.xserver.enable = true;
      services.xserver.desktopManager.gnome.enable = true;

      services.xserver.xkb.layout = "us";
      services.xserver.videoDrivers = [ "modesetting" ];
      environment.systemPackages = with pkgs; [
        kicad
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

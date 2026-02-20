{ config, pkgs, nvim-config, hypr-config, ghostty-config, ...}:
{
 xdg.enable = true;
 xdg.configFile."nvim".source = "./nvim";
 xdg.configFile."hypr" = {
 	source = "./hyperland-config";
	target = "hypr";
 };
 
 xdg.configFile."ghostty" = {
 	source = "./ghosty-config";
	target = "ghostty";
 };
 home = 
 {
   username = "elWapo";
   homeDirectory = "/home/elWapo";
   stateVersion = "25.11";
   packages = with pkgs; [
    hello
    fastfetch
    qbittorrent
    protonvpn-gui
    vscode
    gcc-arm-embedded
    openocd
    unzip
    ripgrep
   ];
   file = {
    "hello-file" = 
    {
     text = "echo 'hello world'";
     executable = true;
    };
   };
 };
}

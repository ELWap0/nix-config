{
 description = "my flake config";
 inputs = 
 {
  nixpkgs.url =  "github:NixOS/nixpkgs/nixos-unstable";
  nixpkgsStable.url = "github:NixOS/nixpkgs/nixos-25.11";
  home-manager = 
  {
   url = "github:nix-community/home-manager";
   inputs.nixpkgs.follows = "nixpkgs";
  };
 };
 outputs = {self, nixpkgs, nixpkgsStable, home-manager, ...}@inputs : 
 let 
   lib = nixpkgs.lib;
   system = "x86_64-linux";
   pkgs = import nixpkgs { inherit system; };
 in
 {
  nixosConfigurations = 
  {
   laptop-buddy = lib.nixosSystem{
   modules = 
   [
    ./configuration.nix
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.elWapo = ./home.nix;
      #home-manager.extraSpecialArgs = 
      #{
        #inherit nvim-config hypr-config ghostty-config;
      #};
    }
   ];
   };
  };
 };
}

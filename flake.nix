{
  description = "Flake for DjVu-related software";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=release-24.11";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system} = import ./default.nix { inherit pkgs; };
  };
}

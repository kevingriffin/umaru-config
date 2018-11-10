{ ... }:

{
  nixpkgs.overlays = [
    (import ./overlays/packages.nix)
  ];
}

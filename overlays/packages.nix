self: super: {
  eikaiwa-packages = super.callPackage ./packages/eikaiwa-environment.nix {};
  seeing_is_believing = super.callPackage ./packages/seeing_is_believing/default.nix {};
}

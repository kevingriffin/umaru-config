self: super: {
  seeing_is_believing = super.callPackage ./packages/seeing_is_believing/default.nix {};
  iknow-devops = super.callPackage ./packages/iknow-devops.nix {};
  iknow-devops-legacy = super.callPackage ./packages/iknow-devops-legacy.nix {};
  phraseapp_updater = super.callPackage ./packages/phraseapp_updater {};
  chef-11 = super.callPackage ./packages/chef-11 {};
  chef-ctl = super.callPackage ./packages/chef-ctl {};
  capistrano = super.callPackage ./packages/capistrano {};
  csshx = super.callPackage ./packages/csshx.nix {};
  cfn-lint = self.python2.pkgs.callPackage ./packages/cfn-lint.nix {};
  cfn_flip = self.python2.pkgs.callPackage ./packages/cfn_flip.nix {};
  hex = super.callPackage ./packages/hex.nix {};
  kube-ps1 = super.callPackage ./packages/kube-ps1.nix {};
  ndppd = super.callPackage ./packages/ndppd {};
  nomino = super.callPackage ./packages/nomino.nix {};
  lorri = let
    src = builtins.fetchGit {
      url = "https://github.com/target/lorri";
      ref = "rolling-release";
      };
      in import src { inherit src; };
  python38 = super.python38.override {
    packageOverrides = pythonSelf: pythonSuper: {
      apsw = pythonSuper.callPackage ./packages/apsw_python.nix {};
    };
  };
}

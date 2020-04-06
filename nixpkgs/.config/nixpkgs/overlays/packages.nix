self: super: {
  seeing_is_believing = super.callPackage ./packages/seeing_is_believing/default.nix {};
  _1password = super.callPackage ./packages/1password/default.nix {};
  iknow-devops = super.callPackage ./packages/iknow-devops.nix {};
  iknow-devops-legacy = super.callPackage ./packages/iknow-devops-legacy.nix {};
  phraseapp_updater = super.callPackage ./packages/phraseapp_updater {};
  chef-11 = super.callPackage ./packages/chef-11 {};
  chef-ctl = super.callPackage ./packages/chef-ctl {};
  capistrano = super.callPackage ./packages/capistrano {};
  csshx = super.callPackage ./packages/csshx.nix {};
  cfn-lint = self.python2.pkgs.callPackage ./packages/cfn-lint.nix {};
  cfn_flip = self.python2.pkgs.callPackage ./packages/cfn_flip.nix {};
  kube-ps1 = super.callPackage ./packages/kube-ps1.nix {};
  ndppd = super.callPackage ./packages/ndppd {};
  lorri = let
    src = builtins.fetchGit {
      url = "https://github.com/target/lorri";
      ref = "rolling-release";
      };
      in import src { inherit src; };
}

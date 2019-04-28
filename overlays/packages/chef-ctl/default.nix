{ writeShellScriptBin, bundlerEnv, bundler, ruby, defaultGemConfig, fetchpatch, tree }:

let
  fix-yajl = fetchpatch {
    url = "https://github.com/chef/ffi-yajl/commit/ba84d91986c2d149f0a05132401e8ad9d17dab6c.diff";
    sha256 = "0vfmdxgpcd0v2y4r5k27lnydqh3hb0zg8f24hlrddi4p7xi93815";
  };

  gems = bundlerEnv {
    name = "chef-ctl-env";
    inherit ruby;
    gemdir = ./.;
    gemConfig = defaultGemConfig // {
      ffi-yajl = attrs: {
        dontBuild = false;
        patches = (attrs.patches or []) ++ [ fix-yajl ];
      };
    };
  };


  src = builtins.fetchGit {
    url = "git@github.com:iknow/chef-ctl";
    rev = "934cb5fc1828cd0697ccfa627efa7b27e721f750";
  };
in

writeShellScriptBin "chef-ctl" ''
  ${gems}/bin/bundle exec ${src}/chef-ctl "$@"
''

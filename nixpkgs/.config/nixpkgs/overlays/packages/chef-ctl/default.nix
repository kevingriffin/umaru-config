{ writeShellScriptBin, bundlerEnv, bundler, ruby, defaultGemConfig, fetchpatch, tree, tmux-cssh }:

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
    rev = "c78688b8201d4c92237d420ac794e1f48c12ec3a";
  };
in

writeShellScriptBin "chef-ctl" ''
  : ''${CHEF_CTL_CSSH:=${tmux-cssh}/bin/tmux-cssh}
  export CHEF_CTL_CSSH
  ${gems}/bin/bundle exec ${src}/chef-ctl "$@"
''

{ stdenv, lib, buildEnv
, chef-11, chef-ctl, capistrano, tmux-cssh
}:

buildEnv {
  name = "iknow-devops-legacy";
  pathsToLink = [ "/bin" ];
  paths = [
    chef-11
    chef-ctl
    capistrano
    tmux-cssh
  ];
}

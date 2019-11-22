{ stdenv, lib, buildEnv
, chef-11, chef-ctl, capistrano
}:

buildEnv {
  name = "iknow-devops-legacy";
  pathsToLink = [ "/bin" ];
  paths = [
    chef-11
    chef-ctl
    capistrano
  ];
}

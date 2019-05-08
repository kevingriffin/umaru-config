{ config, lib, pkgs, ... }:

{
  options = {
    ids.uids = lib.mkOption {
      internal = true;
      description = "ids used by nix-darwin modules in my dotfiles";
    };

    ids.gids = lib.mkOption {
      internal = true;
      description = "ids used by nix-darwin modules in my dotfiles";
    };
  };

  config = {
    users.knownUsers = [ "nginx" ];
    users.knownGroups = [ "nginx" ];

    ids.uids = {
      nginx = 42000;
    };

    ids.gids = {
      nginx = 42000;
    };
  };
}

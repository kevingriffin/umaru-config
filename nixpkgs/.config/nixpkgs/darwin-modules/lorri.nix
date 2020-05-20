{ config, pkgs, lib, ... }:

{
  imports = [<iknow/darwin-modules>];
  services.lorri.enable = true;
}

{ config, lib, pkgs, ... }:

{
  # For learning_engine tests
  services.mysql.enable = true;
  services.mysql.package = pkgs.mysql55;
  services.mysql.extraOptions = ''
    innodb_file_per_table = 1
  '';
}

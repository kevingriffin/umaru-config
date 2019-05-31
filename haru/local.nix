{ config, pkgs, options, ... }:

{
  imports = [
    ../modules/ruby-development.nix
  ];

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 4;
  nix.buildCores = 3;

  services.prometheus.exporters.node.enable = true;
}

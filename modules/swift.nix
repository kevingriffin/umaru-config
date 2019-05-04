{ config, pkgs, ... }:

let
  unstablePkgs = import<nixpkgs-unstable> {};
in
{
  environment.systemPackages = with pkgs; [
    unstablePkgs.swift
  ];

}

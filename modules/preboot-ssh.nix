{ config, pkgs, ... }:

let
  initrdSSHKeys = map (x: x.key) (builtins.fromJSON (builtins.readFile /home/kevin/identities/ssh.json));
in
{
  boot.initrd = {
    availableKernelModules = [ "vmxnet3" "virtio_pci" ];

    network.enable = true;

    network.ssh = {
      enable = true;
      port = 2022;
      authorizedKeys = initrdSSHKeys;
      hostECDSAKey = /etc/nixos/ecdsa_host_key;
    };
  };
}

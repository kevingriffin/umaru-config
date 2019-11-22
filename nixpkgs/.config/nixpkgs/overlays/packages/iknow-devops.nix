{ stdenv, lib, buildEnv
, kubectl, kops, kubectx, kustomize, kube-ps1
, skopeo, cfn_flip, k9s, awscli
}:

buildEnv {
  name = "iknow-devops";
  pathsToLink = [ "/bin" ];
  paths = [
    awscli
    k9s
    kubectl
    kops
    kubectx
    kustomize
    kube-ps1
    skopeo
    cfn_flip
  ];
}

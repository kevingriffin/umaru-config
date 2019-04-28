{ stdenv, lib, buildEnv
, kubectl, kops, kubectx, kustomize, kube-ps1
, skopeo, cfn_flip
}:

buildEnv {
  name = "iknow-devops";
  pathsToLink = [ "/bin" ];
  paths = [
    kubectl
    kops
    kubectx
    kustomize
    kube-ps1
    skopeo
    cfn_flip
  ];
}

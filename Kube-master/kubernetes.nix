{ config, pkgs, ... }:
let
  kubeMasterIP = "192.168.122.173";
  kubeMasterHostname = "api.kube";
  kubeMasterAPIServerPort = 6443;
in
{
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";
  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
            (wrapHelm kubernetes-helm {
              plugins = with pkgs.kubernetes-helmPlugins; [
                helm-diff
                helm-secrets
                helm-s3
              ];
            })
  ];

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = kubeMasterHostname;
    apiserverAddress = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
    easyCerts = true;
    etcd.enable = true;
    apiserver = {
      securePort = kubeMasterAPIServerPort;
      advertiseAddress = kubeMasterIP;
    };

    addons.dns.enable = true;
    kubelet.extraOpts = "--fail-swap-on=false";
  };


  services.flannel.enable = true;
  services.flannel.backend = {
    type = "vxlan";
  };
}

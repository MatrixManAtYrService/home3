{ config, pkgs, ... }:
{



    services.kubernetes = {
      roles = ["master" "node"];
      masterAddress = "api.kube";
      apiserverAddress = "https://api.kube:6443";
      easyCerts = true;
      apiserver = {
        securePort = 6443;
	advertiseAddress = "192.168.90.13";
      };
    };
}

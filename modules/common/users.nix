{ config, pkgs, ... }:

{
  users.users.th1enq = {
    isNormalUser = true;
    group = "th1enq";
    extraGroups = [
      "wheel"
      "docker"
      "input"
      "networkmanager"
      "wireshark"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  users.groups.th1enq = { };
}

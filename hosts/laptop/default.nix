{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./hosts.nix
    ../../modules/common/boot.nix
    ../../modules/common/networking.nix
    ../../modules/common/common.nix
    ../../modules/common/packages.nix
    ../../modules/common/users.nix
    ../../modules/common/shell.nix

    ../../modules/hardware/intel-graphics.nix
    # ../../modules/hardware/nvidia.nix

    ../../modules/desktop/fonts.nix
    ../../modules/desktop/display_manager.nix
    ../../modules/desktop/input.nix
    ../../modules/desktop/sway.nix

    ../../modules/services/docker.nix
    ../../modules/services/battery.nix
    ../../modules/services/pipewire.nix
    ../../modules/services/touchpad.nix
    ../../modules/services/vmware.nix
    ../../modules/services/wireshark.nix
    ../../modules/security/firewall.nix
    ../../modules/security/sudo.nix
  ];

  networking.hostName = "laptop";

  nixpkgs.overlays = [
    (import ../../overlays)
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";

  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };

  services.fstrim.enable = true;

  services.journald.extraConfig = ''
    SystemMaxUse=200M
    RuntimeMaxUse=200M
  '';

  fileSystems."/".options = [ "noatime" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}

{
  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.graphics.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
  };
}

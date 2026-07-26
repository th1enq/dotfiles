{
  inputs,
  pkgs,
  ...
}:

{
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  imports = [
    inputs.fcitx5-lotus.nixosModules.fcitx5-lotus
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [
      inputs.fcitx5-lotus.packages.${pkgs.stdenv.hostPlatform.system}.fcitx5-lotus
    ];
  };

  services.fcitx5-lotus = {
    enable = true;
    users = [ "th1enq" ];
  };
}

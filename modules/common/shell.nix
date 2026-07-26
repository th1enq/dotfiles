{ pkgs, ... }:

{
  programs.zsh.enable = true;

  environment.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    SAL_USE_VCLPLUGIN = "qt6";
    QT_QPA_PLATFORM = "wayland";
  };
}

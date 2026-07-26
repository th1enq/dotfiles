{ pkgs, ... }:

let
  pname = "antigravity";
  version = "2.1.1";

  src = pkgs.fetchurl {
    url = "https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/2.1.1-6123990880747520/linux-x64/Antigravity%20IDE.tar.gz";
    hash = "sha256-Wyzr99M6aNAD/Y8fqYjRYAkFrOIlBKCF5ThCFCkIeL0=";
  };
in

pkgs.stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    openssl

    glib
    gtk3
    nss
    nspr
    dbus
    expat
    cups
    alsa-lib

    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    xorg.libxkbfile

    mesa
    libdrm

    webkitgtk_4_1
    libsoup_3
    libsecret
  ];

  unpackPhase = ''
    runHook preUnpack

    mkdir source
    tar -xzf $src -C source --strip-components=1

    find source -perm /4000 -exec chmod u-s {} + || true

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt/antigravity
    cp -r source/* $out/opt/antigravity/

    mkdir -p $out/bin

    BIN=$(find $out/opt/antigravity -type f -executable -name "antigravity" | head -n 1 || true)

    if [ -z "$BIN" ]; then
      BIN=$(find $out/opt/antigravity -type f -executable | grep -Ei "antigravity|code|electron" | head -n 1 || true)
    fi

    if [ -z "$BIN" ]; then
      echo "Cannot find antigravity binary"
      find $out/opt/antigravity -type f -executable | head -50
      exit 1
    fi

    ln -s "$BIN" $out/bin/antigravity

    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/antigravity \
      --set NIXOS_OZONE_WL 1 \
      --set ELECTRON_OZONE_PLATFORM_HINT wayland \
      --set GDK_BACKEND wayland \
      --add-flags "--no-sandbox" \
      --add-flags "--ozone-platform=wayland" \
      --add-flags "--enable-features=UseOzonePlatform,WaylandWindowDecorations"
  '';

  meta = {
    description = "Google Antigravity IDE packaged from tar.gz for NixOS Wayland";
    platforms = [ "x86_64-linux" ];
  };
}

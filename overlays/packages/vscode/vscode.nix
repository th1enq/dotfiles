{
  vscode,
  fetchurl,
  curl,
  libsoup_3,
  openssl,
  webkitgtk_4_1,
  libXtst,
  libjpeg8,
  pipewire,
  libei,
  ...
}:

let
  version = "1.128.0";

  src = fetchurl {
    name = "VSCode-linux-x64-${version}.tar.gz";
    url = "https://update.code.visualstudio.com/${version}/linux-x64/stable";
    hash = "sha256-qbTOl07MEMdFbamHl2O/CnpDJxC9JslaiaihaPKv9Xs=";
  };
in
vscode.overrideAttrs (oldAttrs: {
  inherit version src;

  patches = [ ];

  prePatch = "";
  postPatch = "";

  patchPhase = ''
    runHook prePatch
    runHook postPatch
  '';

  buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
    curl
    openssl
    webkitgtk_4_1
    libsoup_3
    libXtst
    libjpeg8
    pipewire
    libei
  ];
})

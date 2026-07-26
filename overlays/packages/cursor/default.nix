{ pkgs, ... }:
let
  pname = "cursor";
  version = "0.50.5";

  src = pkgs.fetchurl {
    url = "https://downloads.cursor.com/production/fce1e9ab7844f9ea35793da01e634aa7e50bce90/linux/x64/Cursor-3.1.17-x86_64.AppImage";
    hash = "sha256-+Pk5MvQSjhoKJdtN+pWX/vcyWnHmbXvJ5wFDvgtHo20=";
  };
  appimageContents = pkgs.appimageTools.extract { inherit pname version src; };
in
with pkgs;
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-quiet 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share

    if [ -e ${appimageContents}/AppRun ]; then
      install -m 755 -D ${appimageContents}/AppRun $out/bin/${pname}-${version}
      if [ ! -L $out/bin/${pname} ]; then
        ln -s $out/bin/${pname}-${version} $out/bin/${pname}
      fi
    else
      echo "Error: Binary not found in extracted AppImage contents."
      exit 1
    fi
  '';

  extraBwrapArgs = [ "--bind-try /etc/nixos/ /etc/nixos/" ];

  dieWithParent = false;

  extraPkgs = pkgs: [
    unzip
    autoPatchelfHook
    asar
    (buildPackages.wrapGAppsHook3.override {
      inherit (buildPackages) makeWrapper;
    })
  ];
}

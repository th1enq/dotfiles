{ pkgs, ... }:

let
  pname = "codex";
  version = "0.144.6";

  wrapperSrc = pkgs.fetchurl {
    url = "https://registry.npmjs.org/@openai/codex/-/codex-${version}.tgz";
    hash = "sha256-d56rJaqEc1g7PR1vkxagq40GQ/39C/74DOdsyM+F5AE=";
  };

  linuxX64Src = pkgs.fetchurl {
    url = "https://registry.npmjs.org/@openai/codex/-/codex-${version}-linux-x64.tgz";
    hash = "sha256-tnUusujBDm/MlqxcHIrYNCzbmnRQT7hGhq3fCBp9KGg=";
  };
in

pkgs.stdenvNoCC.mkDerivation {
  inherit pname version;

  src = wrapperSrc;

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  unpackPhase = ''
    runHook preUnpack

    mkdir wrapper linux-x64
    tar -xzf ${wrapperSrc} -C wrapper --strip-components=1
    tar -xzf ${linuxX64Src} -C linux-x64 --strip-components=1

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    installRoot="$out/lib/node_modules/@openai"
    mkdir -p "$installRoot/codex" "$installRoot/codex-linux-x64" "$out/bin"

    cp -R wrapper/. "$installRoot/codex/"
    cp -R linux-x64/. "$installRoot/codex-linux-x64/"

    chmod +x "$installRoot/codex-linux-x64/vendor/x86_64-unknown-linux-musl/bin/codex"
    chmod +x "$installRoot/codex-linux-x64/vendor/x86_64-unknown-linux-musl/codex-path/rg"
    chmod +x "$installRoot/codex-linux-x64/vendor/x86_64-unknown-linux-musl/codex-resources/bwrap"
    chmod +x "$installRoot/codex-linux-x64/vendor/x86_64-unknown-linux-musl/codex-resources/zsh/bin/zsh"

    makeWrapper ${pkgs.nodejs}/bin/node "$out/bin/codex" \
      --add-flags "$installRoot/codex/bin/codex.js"

    runHook postInstall
  '';

  meta = {
    description = "OpenAI Codex CLI installed directly from the official npm release";
    homepage = "https://github.com/openai/codex";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "codex";
    platforms = [ "x86_64-linux" ];
  };
}

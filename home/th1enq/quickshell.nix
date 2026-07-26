{ pkgs, ... }:

let
  quickshellLauncher = pkgs.writeShellScriptBin "quickshell-launcher" ''
    set -euo pipefail

    focused_output() {
      ${pkgs.sway}/bin/swaymsg -t get_workspaces 2>/dev/null \
        | ${pkgs.jq}/bin/jq -r '.[] | select(.focused) | .output' 2>/dev/null \
        | head -n1
    }

    output="$(focused_output || true)"

    if ${pkgs.quickshell}/bin/qs ipc -c launcher call launcher toggle "$output" >/dev/null 2>&1; then
      exit 0
    fi

    ${pkgs.quickshell}/bin/quickshell --config launcher --no-duplicate --daemonize >/dev/null 2>&1 || true
    sleep 0.15
    output="$(focused_output || true)"
    ${pkgs.quickshell}/bin/qs ipc -c launcher call launcher show "$output" >/dev/null 2>&1 || true
  '';

  quickshellLock = pkgs.writeShellScriptBin "quickshell-lock" ''
    set -euo pipefail

    dir="''${XDG_RUNTIME_DIR:-/tmp}"

    swaymsg -t get_outputs \
      | ${pkgs.jq}/bin/jq -r '.[] | select(.active) | .name' \
      | while IFS= read -r output; do
        [ -n "$output" ] || continue
        rm -f "$dir/ricelin-lock-$output.png"
        ${pkgs.grim}/bin/grim -o "$output" "$dir/ricelin-lock-$output.png" 2>/dev/null || true
      done

    if ${pkgs.quickshell}/bin/qs ipc -c lock call lock lock >/dev/null 2>&1; then
      exit 0
    fi

    QML2_IMPORT_PATH=${./quickshell/lock}:''${QML2_IMPORT_PATH:-} \
    QML_XHR_ALLOW_FILE_READ=1 \
      ${pkgs.quickshell}/bin/quickshell --config lock --no-duplicate --daemonize >/dev/null 2>&1 || true
    sleep 0.15
    ${pkgs.quickshell}/bin/qs ipc -c lock call lock lock >/dev/null 2>&1
  '';
in
{
  programs.quickshell = {
    enable = true;
    package = pkgs.quickshell;
    activeConfig = "launcher";
    configs = {
      launcher = ./quickshell/launcher;
      lock = ./quickshell/lock;
    };
  };

  home.packages = [
    pkgs.cava
    pkgs.curl
    pkgs.fd
    pkgs.mpv
    pkgs.xdg-utils
    pkgs.yt-dlp
    quickshellLauncher
    quickshellLock
  ];
}

final: prev: {
  # antigravity = final.callPackage ./packages/antigravity { };
  codex = final.callPackage ./packages/codex { };
  # cursor = final.callPackage ./packages/cursor { };
  vscode = final.callPackage ./packages/vscode/vscode.nix {
    vscode = prev.vscode;
  };
}

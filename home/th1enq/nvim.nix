{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    clang-tools
    curl
    docker-compose-language-service
    dockerfile-language-server
    gcc
    go
    gopls
    isort
    jdk
    jdt-language-server
    lemminx
    nixd
    nixfmt-rfc-style
    neovide
    ruff
    stylua
    vscode-langservers-extracted
    yaml-language-server
  ];
}

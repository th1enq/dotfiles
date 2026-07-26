{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    htop
    pciutils
    fastfetch
    unzip
    jq
    zip

    go
    rustc
    cargo
    python3
    ruby
    nodejs
    gcc

    docker_29
    docker-compose

    pamixer
    pavucontrol

    glib
    mesa
    mesa-demos

    pkg-config
    openssl
  ];
}

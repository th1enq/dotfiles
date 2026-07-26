{ config, ... }:

{
  home.username = "th1enq";
  home.homeDirectory = "/home/th1enq";
  home.stateVersion = "25.11";

  imports = [
    ./packages.nix

    ./keyboard.nix
    ./zsh.nix
    ./tmux.nix
    ./nvim.nix
    ./kitty.nix
    ./git.nix
    ./sway.nix
    ./waybar.nix
    ./fastfetch.nix
    ./zathura.nix
    ./mako.nix
    ./browser.nix
    ./quickshell.nix
  ];
}

{ config, pkgs, ... }:

{
  time.timeZone = "Asia/Ho_Chi_Minh";

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}

{ pkgs, ... }:
pkgs.fetchFromGitHub {
  owner = "catppuccin";
  repo = "spicetify";
  rev = "4294a61f54a044768c6e9db20e83c5b74da71091";
  sha256 = "0k0rSxjyzU5cjn2mTNqGHwo30Ar5rF0a+G/GG5xaL8U=";
}

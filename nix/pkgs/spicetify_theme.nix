{ pkgs, ... }:
pkgs.fetchFromGitHub {
  owner = "catppuccin";
  repo = "spicetify";
  rev = "ba3986981c717856d9ec68412c95ae282b505538";
  sha256 = "0k0rSxjyzU5cjn2mTNqGHwo30Ar5rF0a+G/GG5xaL8U=";
}

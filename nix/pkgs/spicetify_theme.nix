{ pkgs, ... }:
pkgs.fetchFromGitHub {
  owner = "catppuccin";
  repo = "spicetify";
  rev = "1ec645c4cf7f42f9792b9eeb1bb7930f94593277";
  sha256 = "VK9JpXYFuLMkIuMftFkkMy6Y5+ttuxDUYoIiAPlx6YY=";
}

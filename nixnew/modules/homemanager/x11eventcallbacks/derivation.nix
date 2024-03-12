{ stdenv, lib, pkgs, fetchFromGitHub }:

with lib;

let
in stdenv.mkDerivation rec {
  name = "x11eventcallbacks";

  src = fetchFromGitHub {
    owner = "dreadster3";
    repo = "x11_event_callbacks";
    rev = "3affce5766901c9741c7a45611992bb2b4792d6b";
    sha256 = "sldoJPf3wLu7oI69FuAVlfilE+3C6vVCEi/4x3faMSY=";
  };

  nativeBuildInputs = with pkgs.buildPackages; [ cmake gcc gnumake ];

  buildInputs = with pkgs.buildPackages; [ xorg.libX11 xorg.libX11.dev ];

  installPhase = ''
    cmake --build /build/source/build --target install
  '';
}

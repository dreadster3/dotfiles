{
  stdenv,
  lib,
  fetchFromGitHub,
  cmake,
  xorg,
}:

stdenv.mkDerivation {
  pname = "x11eventcallbacks";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "dreadster3";
    repo = "x11_event_callbacks";
    rev = "3affce5766901c9741c7a45611992bb2b4792d6b";
    sha256 = "sldoJPf3wLu7oI69FuAVlfilE+3C6vVCEi/4x3faMSY=";
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [ xorg.libX11 ];

  meta = {
    description = "X11 event callback utility";
    homepage = "https://github.com/dreadster3/x11_event_callbacks";
    license = lib.licenses.mit;
    mainProgram = "x11eventcallbacks";
    platforms = lib.platforms.unix;
  };
}

{
  stdenv,
  lib,
  pkgs,
  fetchFromGitHub,
}:

with lib;

let
in
stdenv.mkDerivation rec {
  name = "obsmic";

  src = fetchFromGitHub {
    owner = "dreadster3";
    repo = "OBSVirtualMic";
    rev = "7c9c21017022ec4291d0b554a80657cff9fc9f91";
    sha256 = "zZLdGzI6ud5z/lnBnK6Q2lEcWMv2EKRtQqhEv+CBCNA=";
  };

  installPhase = ''
    chmod +x ./main.sh
    mkdir -p $out/bin
    cp ./main.sh $out/bin/obsmic
  '';
}

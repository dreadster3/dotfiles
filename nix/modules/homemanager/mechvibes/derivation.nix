{ appimageTools, lib, fetchurl, writers }:

let
  pname = "mechvibes";
  version = "2.3.4";

  src = fetchurl {
    url =
      "https://github.com/hainguyents13/mechvibes/releases/download/v${version}/Mechvibes-${version}.AppImage";
    sha256 = "sha256-imnXVchw85WREGGME/OMdRKuOfHYiSRoqUEy3ecRw1Y=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop --replace 'Exec=AppRun' 'Exec=${pname} --disable-seccomp-filter-sandbox'
    cp -r ${appimageContents}/usr/share/icons $out/share'';

  meta = with lib; {
    description = "Play mechanical keyboard sounds as you type.";
    mainProgram = "mechvibes";
    homepage = "https://mechvibes.com/";
    license = licenses.mit;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}

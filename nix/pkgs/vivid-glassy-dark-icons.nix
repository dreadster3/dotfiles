{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
  gtk3,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "Vivid-Glassy-Dark-Icons";
  version = "unstable-2024-07-23";

  src = fetchFromGitHub {
    owner = "L4ki";
    repo = "Vivid-Plasma-Themes";
    rev = "605d2b15eb499f44cc9d394750c79bec68a9564e";
    hash = "sha256-BPY9KhJ+l9YBkSnWB2ETwG7mSYRC3t/XJE6rLP8CqtE=";
  };

  nativeBuildInputs = [ gtk3 ];

  dontDropIconThemeCache = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    cp -r ./Vivid\ Icons\ Themes/Vivid-Glassy-Dark-Icons $out/share/icons/${pname}
    gtk-update-icon-cache $out/share/icons/${pname}

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/L4ki/Vivid-Plasma-Themes";
    description = "Vivid Plasma Themes";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}

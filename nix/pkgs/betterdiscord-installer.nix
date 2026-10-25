{
  appimageTools,
  lib,
  fetchzip,
}:
let
  pname = "betterdiscord-installer";
  version = "2.0.0";

  src = fetchzip {
    url = "https://github.com/BetterDiscord/Installer/releases/download/v${version}/BetterDiscord-Installer-Linux.AppImage.zip";
    hash = "sha256-W6bFv8TY7SDvbelu/wbDrSfQkD9mRn+m5D1OOxUjEzw=";
    stripRoot = false;
  };

  appimageContents = appimageTools.extract {
    inherit pname version;
    src = "${src}/BetterDiscord-Installer-Linux.AppImage";
  };
in
appimageTools.wrapType2 {
  inherit pname version;
  src = "${src}/BetterDiscord-Installer-Linux.AppImage";

  # Tauri app: needs webkit2gtk-4.1 at runtime, which the default AppImage libs don't include
  extraPkgs = p: [
    p.gtk3
    p.glib
    p.webkitgtk_4_1
    p.libsoup_3
    p.gdk-pixbuf
  ];

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/betterdiscord-installer.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/betterdiscord-installer.desktop \
      --replace-fail 'Exec=BetterDiscord-Installer' 'Exec=betterdiscord-installer'
    install -m 444 -D ${appimageContents}/betterdiscord-installer.png $out/share/icons/hicolor/512x512/apps/betterdiscord-installer.png
  '';

  meta = {
    description = "Installer for BetterDiscord";
    homepage = "https://betterdiscord.app";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "betterdiscord-installer";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}

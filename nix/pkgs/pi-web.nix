{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs_24,
  makeWrapper,
}:

buildNpmPackage rec {
  pname = "pi-web";
  version = "0.9.3";

  src = fetchFromGitHub {
    owner = "agegr";
    repo = "pi-web";
    rev = "v${version}";
    hash = "sha256-EhoxOwmEIsN3G6MQImZbCSJM4QBnnzKzNV+gmuIUkN0=";
  };

  npmDepsHash = "sha256-8HJ2S5soReHvwXEKg31sd7iTKYQKbzMb/UpDRe/sR2E=";
  npmDepsFetcherVersion = 2;

  nodejs = nodejs_24;

  # app/layout.tsx pulls Noto Sans Mono from Google Fonts at build time, which
  # fails in the sandbox. The stylesheet already falls back through
  # 'JetBrains Mono', 'Fira Code', 'Consolas', ui-monospace, monospace, so drop
  # the remote font and emit the CSS variable as an empty default instead.
  postPatch = ''
    substituteInPlace app/layout.tsx \
      --replace-fail 'import { Noto_Sans_Mono } from "next/font/google";' "" \
      --replace-fail 'const notoSansMono = Noto_Sans_Mono({' 'const notoSansMono = ((_: unknown) => ({ variable: "" }))({' 
  '';

  npmBuildScript = "build";

  installPhase = ''
    runHook preInstall

    appDir="$out/lib/pi-web"
    mkdir -p "$appDir" "$out/bin"

    cp -r . "$appDir/"
    rm -rf "$appDir/.next/cache" "$appDir/.next/dev"

    makeWrapper ${lib.getExe nodejs_24} "$out/bin/pi-web" \
      --add-flags "$appDir/bin/pi-web.js"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Web UI for the pi coding agent";
    homepage = "https://github.com/agegr/pi-web";
    license = licenses.mit;
    mainProgram = "pi-web";
    platforms = platforms.linux ++ platforms.darwin;
  };
}

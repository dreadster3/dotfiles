{
  lib,
  stdenv,
  buildNpmPackage,
  fetchFromGitHub,
  electron_39,
  makeWrapper,
  makeDesktopItem,
  copyDesktopItems,
  nodejs,
  python3,
  # Python with uv — the app manages its own Python/uv at runtime but
  # having python3 in PATH ensures the startup detection works on NixOS.
  # commandLineArgs which are always set
  commandLineArgs ? "",
}:

let
  electron = electron_39;
in
buildNpmPackage rec {
  pname = "open-webui-desktop";
  version = "0.0.20";

  src = fetchFromGitHub {
    owner = "open-webui";
    repo = "desktop";
    rev = "v${version}";
    hash = "sha256-hPMmAHffGqGiopSagXhrQY4HAyf5e9qmXlTfzqgBJz8=";
  };

  npmDepsHash = "sha256-idzuBFaHfRvFGuLFa4TIl/pfzzmuhqHBBh0Siv9yEpY=";

  # The app uses native modules (node-pty) that need compilation
  npmRebuildFlags = [ "--build-from-source" ];

  # Don't let npm/electron-builder try to download electron binaries;
  # we use the nixpkgs electron instead.
  env = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
  };

  nativeBuildInputs = [
    nodejs
    electron
    makeWrapper
    copyDesktopItems
    python3
  ];

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    electron
  ];

  # Skip the typecheck step — it requires a full TS setup and some ambient
  # types are only resolved at runtime.  We run the vite build directly.
  buildPhase = ''
    runHook preBuild

    npx electron-vite build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    appDir="$out/share/open-webui"
    mkdir -p "$appDir"

    # ----------------------------------------------------------------
    # Built output (main process, preload, renderer HTML/JS/CSS)
    # ----------------------------------------------------------------
    cp -r out "$appDir/out"

    # Static resources (icon, tray image, chime sounds)
    cp -r resources "$appDir/resources"

    # CHANGELOG.md is read at runtime by the settings About panel
    cp CHANGELOG.md "$appDir/"

    # package.json tells electron where the main entry point is
    # and provides the app version string.
    cp package.json "$appDir/"

    # ----------------------------------------------------------------
    # Runtime node_modules
    # electron-vite externalises npm packages (node-pty, electron-log,
    # electron-updater, tar, @electron-toolkit/*, …) that are resolved
    # via require() at runtime.  We prune dev-only dependencies so only
    # production packages (plus their transitive deps) are shipped.
    # ----------------------------------------------------------------
    npm prune --omit=dev
    cp -r node_modules "$appDir/node_modules"

    # ----------------------------------------------------------------
    # Vite does not copy icon.png into out/main/assets/ — it only
    # records the ?asset import as a relative path.  Several
    # BrowserWindow constructors reference
    #   path.join(__dirname, "assets/icon.png")
    # at runtime, so we supply it as a copy of the resource icon.
    # ----------------------------------------------------------------
    mkdir -p "$appDir/out/main/assets"
    cp build/icon.png "$appDir/out/main/assets/icon.png"

    # ----------------------------------------------------------------
    # Desktop icon
    # ----------------------------------------------------------------
    mkdir -p "$out/share/icons/hicolor/512x512/apps"
    cp build/icon.png "$out/share/icons/hicolor/512x512/apps/open-webui.png"

    # ----------------------------------------------------------------
    # Wrapper binary
    #
    # Environment variables:
    #   ELECTRON_FORCE_IS_PACKAGED=1    — tells the app it's in production
    #                                     (disables auto-devtools, enable update checks)
    #   ELECTRON_DISABLE_SANDBOX=1      — required on NixOS (no chrome-sandbox setuid)
    #
    # CLI flags:
    #   --no-sandbox                     — belt-and-suspenders with the env var;
    #                                     some environments need both
    #   --ozone-platform-hint=auto       — native Wayland when available, X11 fallback
    #   --enable-features=WaylandWindowDecorations
    #                                    — client-side decorations on Wayland
    #   --enable-features=UseOzonePlatform
    #                                    — ensures the Ozone backend is used (needed
    #                                     for Wayland + NVIDIA to avoid software render)
    #   --enable-gpu-rasterization       — use the GPU for tile rasterization
    #   --enable-zero-copy               — reduce GPU→CPU copies for smoother scrolling
    #
    # The Wayland flags are gated behind NIXOS_OZONE_WL (set by
    # environment.sessionVariables.NIXOS_OZONE_WL in the NixOS module)
    # so that X11-only setups aren't affected.
    # ----------------------------------------------------------------
    mkdir -p "$out/bin"
    makeWrapper ${lib.getExe electron} "$out/bin/open-webui-desktop" \
      --add-flags "$appDir" \
      --add-flags "--no-sandbox" \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations,UseOzonePlatform}}" \
      --add-flags "--enable-features=UseOzonePlatform" \
      --add-flags "--enable-gpu-rasterization" \
      --add-flags "--enable-zero-copy" \
      --add-flags ${lib.escapeShellArg commandLineArgs} \
      --set ELECTRON_FORCE_IS_PACKAGED 1 \
      --set ELECTRON_DISABLE_SANDBOX 1 \
      --prefix PATH : ${lib.makeBinPath [ python3 ]}

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "open-webui";
      exec = "open-webui-desktop %U";
      icon = "open-webui";
      desktopName = "Open WebUI";
      genericName = "AI Chat Client";
      comment = "Run and connect to Open WebUI instances from your desktop";
      categories = [
        "Network"
        "Utility"
      ];
      keywords = [
        "AI"
        "LLM"
        "chat"
        "open-webui"
        "ollama"
      ];
      startupWMClass = "open-webui";
      mimeTypes = [ "x-scheme-handler/open-webui" ];
    })
  ];

  passthru = {
    inherit electron;
  };

  meta = with lib; {
    description = "Open WebUI as a native desktop app — run and connect to Open WebUI instances from your desktop";
    homepage = "https://github.com/open-webui/desktop";
    license = licenses.agpl3Only;
    mainProgram = "open-webui-desktop";
    maintainers = [ ];
    platforms = electron.meta.platforms or platforms.linux;
    sourceProvenance = with sourceTypes; [ fromSource ];
  };
}
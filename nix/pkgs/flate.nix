{
  lib,
  buildGo127Module,
  fetchFromGitHub,
  nix-update-script,
}:

buildGo127Module rec {
  pname = "flate";
  version = "0.6.5";

  src = fetchFromGitHub {
    owner = "home-operations";
    repo = "flate";
    tag = "v${version}";
    hash = "sha256-Z1bhf54xJSrCiLgRfzGuZ7ORzLgdFe5PfEVZzs8hkew=";
  };

  subPackages = [ "cmd/flate" ];

  vendorHash = "sha256-6ZmGkdHW2/8wk/dKN9MkB+JF0/GFIw2TxZHeWShLsQ0=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A Flux resource validator and inflator";
    homepage = "https://github.com/home-operations/flate";
    license = lib.licenses.agpl3Only;
    mainProgram = "flate";
    platforms = lib.platforms.unix;
  };
}

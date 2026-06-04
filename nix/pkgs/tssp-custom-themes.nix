{
  lib,
  stdenvNoCC,
  themesDir,
}:
let
  isThemeFolder = p: p.value == "directory";

  themes = builtins.map (p: p.name) (
    lib.filter isThemeFolder (
      lib.mapAttrsToList (name: value: lib.nameValuePair name value) (
        builtins.readDir themesDir
      )
    )
  );

  makeCustomThemeDerivation = dirName:
    stdenvNoCC.mkDerivation {
      pname = dirName;
      version = "0.0.0";
      src = themesDir;
      installPhase = ''
        cp -a "${dirName}" "$out"
      '';
      meta = {
        description = "Custom TSSP theme: ${dirName}";
        platforms = lib.platforms.all;
      };
    };
in
builtins.listToAttrs (
  builtins.map (dirName: lib.nameValuePair dirName (makeCustomThemeDerivation dirName)) themes
)
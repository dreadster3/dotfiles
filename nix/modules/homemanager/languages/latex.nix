{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.languages.latex;

  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-medium
      pdfx
      xmpincl
      fontawesome5
      markdown
      paralist
      csvsimple
      tcolorbox
      environ
      tikzfill
      enumitem
      dashrule
      ifmtarg
      multirow
      changepage
      biblatex
      paracol
      roboto
      fontaxes
      lato
      ;
  };
in
{
  options = {
    modules.homemanager.languages.latex = {
      enable = mkEnableOption "latex toolchain";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tex
      texlab
      biber
    ];
  };
}

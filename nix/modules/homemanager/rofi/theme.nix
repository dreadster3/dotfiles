{ config, lib, ... }:
with lib;
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  window = {
    enabled = true;

    transparency = "real";
    location = mkLiteral "center";
    anchor = mkLiteral "center";
    fullscreen = false;
    width = mkLiteral "400px";
    x-offset = mkLiteral "0px";
    y-offset = mkLiteral "0px";

    margin = mkLiteral "0px";
    padding = mkLiteral "0px";
    border = mkLiteral "1px solid";
    border-radius = mkLiteral "12px";
    cursor = mkLiteral "default";
  };

  mainbox = {
    enabled = true;
    spacing = mkLiteral "0px";
    margin = mkLiteral "0px";
    padding = mkLiteral "0px";
    border = mkLiteral "0px solid";
    border-radius = mkLiteral "0px 0px 0px 0px";
    background-color = mkLiteral "transparent";
    children = [
      "inputbar"
      "listview"
    ];
  };

  inputbar = {
    enabled = true;
    spacing = mkLiteral "10px";
    margin = mkLiteral "0px";
    padding = mkLiteral "15px";
    border = mkLiteral "0px solid";
    border-radius = mkLiteral "0px";
    children = [
      "prompt"
      "entry"
    ];
  };

  prompt = {
    enabled = true;
    background-color = mkLiteral "inherit";
    text-color = mkLiteral "inherit";
  };

  textbox-prompt-colon = {
    enabled = true;
    expand = false;
    str = "::";
    background-color = mkLiteral "inherit";
  };
  entry = {
    enabled = true;
    background-color = mkLiteral "inherit";
    cursor = mkLiteral "text";
    placeholder = "Search...";
    placeholder-color = mkLiteral "inherit";
  };

  listview = {
    enabled = true;
    columns = 1;
    lines = 6;
    cycle = true;
    dynamic = true;
    scrollbar = false;
    layout = mkLiteral "vertical";
    reverse = false;
    fixed-height = true;
    fixed-columns = true;

    spacing = mkLiteral "5px";
    margin = mkLiteral "0px";
    padding = mkLiteral "0px";
    border = mkLiteral "0px solid";
    border-radius = mkLiteral "0px";
    background-color = mkLiteral "transparent";
    cursor = mkLiteral "default";
  };

  scrollbar = {
    handle-width = mkLiteral "5px";
    border-radius = mkLiteral "0px";
  };

  element = {
    enabled = true;
    spacing = mkLiteral "10px";
    margin = mkLiteral "0px";
    padding = mkLiteral "8px";
    border = mkLiteral "0px solid";
    border-radius = mkLiteral "0px";
    background-color = mkLiteral "transparent";
    cursor = mkLiteral "pointer";
  };
  "element normal.normal" = {
  };
  "element selected.normal" = {
    background-color = mkLiteral "@blue";
  };
  element-icon = {
    size = mkLiteral "32px";
    cursor = mkLiteral "inherit";
  };
  element-text = {
    highlight = mkLiteral "inherit";
    cursor = mkLiteral "inherit";
    vertical-align = mkLiteral "0.5";
    horizontal-align = mkLiteral "0.0";
  };

  error-message = {
    padding = mkLiteral "15px";
    border = mkLiteral "2px solid";
    border-radius = mkLiteral "12px";
  };
  textbox = {
    vertical-align = mkLiteral "0.5";
    horizontal-align = mkLiteral "0.0";
    highlight = mkLiteral "none";
  };
}

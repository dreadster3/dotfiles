{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.homemanager.helix;
  colors = config.modules.homemanager.settings.theme.colors;
in {
  options = {
    modules.homemanager.helix = { enable = mkEnableOption "helix"; };
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      settings = {
        theme = "catppuccin";
        editor = {
          line-number = "relative";
          cursorline = true;
          color-modes = true;

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          indent-guides = { render = true; };
        };
      };
      themes = {
        catppuccin = let
          # catppuccin palette colors
          rosewater = colors.rosewater;
          flamingo = colors.flamingo;
          pink = colors.pink;
          mauve = colors.mauve;
          red = colors.red;
          maroon = colors.maroon;
          peach = colors.peach;
          yellow = colors.yellow;
          green = colors.green;
          teal = colors.teal;
          sky = colors.sky;
          sapphire = colors.sapphire;
          blue = colors.blue;
          lavender = colors.lavender;

          subtext1 = colors.subtext_1;
          subtext0 = colors.subtext_0;
          overlay2 = colors.overlay_2;
          overlay1 = colors.overlay_1;
          overlay0 = colors.overlay_0;
          surface2 = colors.surface_2;
          surface1 = colors.surface_1;
          surface0 = colors.surface_0;

          base = colors.base;
          mantle = colors.mantle;
          crust = colors.crust;
          text = colors.text;

          # derived colors by blending existing palette colors
          cursorline = "#2a2b3c";
          secondary_cursor = "#b5a6a8";
          secondary_cursor_normal = "#878ec0";
          secondary_cursor_insert = "#7da87e";

        in {
          type = yellow;

          constructor = sapphire;

          "constant" = peach;
          "constant.builtin" = peach;
          "constant.character" = teal;
          "constant.character.escape" = pink;

          "string" = green;
          "string.regexp" = peach;
          "string.special" = blue;

          "comment" = {
            fg = overlay1;
            modifiers = [ "italic" ];
          };

          "variable" = text;
          "variable.parameter" = {
            fg = maroon;
            modifiers = [ "italic" ];
          };
          "variable.builtin" = red;
          "variable.other.member" = teal;

          "label" = sapphire; # used for lifetimes

          "punctuation" = overlay2;
          "punctuation.special" = sky;

          "keyword" = mauve;
          "keyword.control.conditional" = {
            fg = mauve;
            modifiers = [ "italic" ];
          };

          "operator" = sky;

          "function" = blue;
          "function.macro" = mauve;

          "tag" = mauve;
          "attribute" = blue;

          "namespace" = {
            fg = blue;
            modifiers = [ "italic" ];
          };

          "special" = blue; # fuzzy highlight

          "markup.heading.marker" = {
            fg = peach;
            modifiers = [ "bold" ];
          };
          "markup.heading.1" = lavender;
          "markup.heading.2" = mauve;
          "markup.heading.3" = green;
          "markup.heading.4" = yellow;
          "markup.heading.5" = pink;
          "markup.heading.6" = teal;
          "markup.list" = mauve;
          "markup.bold" = { modifiers = [ "bold" ]; };
          "markup.italic" = { modifiers = [ "italic" ]; };
          "markup.link.url" = {
            fg = blue;
            modifiers = [ "italic" "underlined" ];
          };
          "markup.link.text" = blue;
          "markup.raw" = flamingo;

          "diff.plus" = green;
          "diff.minus" = red;
          "diff.delta" = blue;

          # User Interface
          # --------------
          "ui.background" = {
            fg = text;
            bg = base;
          };
          "ui.linenr" = { fg = surface1; };
          "ui.linenr.selected" = { fg = lavender; };
          "ui.statusline" = {
            fg = subtext1;
            bg = mantle;
          };
          "ui.statusline.inactive" = {
            fg = surface2;
            bg = mantle;
          };
          "ui.statusline.normal" = {
            fg = base;
            bg = lavender;
            modifiers = [ "bold" ];
          };
          "ui.statusline.insert" = {
            fg = base;
            bg = green;
            modifiers = [ "bold" ];
          };
          "ui.statusline.select" = {
            fg = base;
            bg = flamingo;
            modifiers = [ "bold" ];
          };
          "ui.popup" = {
            fg = text;
            bg = surface0;
          };
          "ui.window" = { fg = crust; };
          "ui.help" = {
            fg = overlay2;
            bg = surface0;
          };
          "ui.bufferline" = {
            fg = subtext0;
            bg = mantle;
          };
          "ui.bufferline.active" = {
            fg = mauve;
            bg = base;
            underline = {
              color = mauve;
              style = "line";
            };
          };
          "ui.bufferline.background" = { bg = crust; };
          "ui.text" = text;
          "ui.text.focus" = {
            fg = text;
            bg = surface0;
            modifiers = [ "bold" ];
          };
          "ui.text.inactive" = { fg = overlay1; };
          "ui.virtual" = overlay0;
          "ui.virtual.ruler" = { bg = surface0; };
          "ui.virtual.indent-guide" = surface0;
          "ui.virtual.inlay-hint" = {
            fg = surface1;
            bg = mantle;
          };
          "ui.selection" = { bg = surface1; };
          "ui.cursor" = {
            fg = base;
            bg = secondary_cursor;
          };
          "ui.cursor.primary" = {
            fg = base;
            bg = rosewater;
          };
          "ui.cursor.match" = {
            fg = peach;
            modifiers = [ "bold" ];
          };
          "ui.cursor.primary.normal" = {
            fg = base;
            bg = lavender;
          };
          "ui.cursor.primary.insert" = {
            fg = base;
            bg = green;
          };
          "ui.cursor.primary.select" = {
            fg = base;
            bg = flamingo;
          };
          "ui.cursor.normal" = {
            fg = base;
            bg = secondary_cursor_normal;
          };
          "ui.cursor.insert" = {
            fg = base;
            bg = secondary_cursor_insert;
          };
          "ui.cursor.select" = {
            fg = base;
            bg = secondary_cursor;
          };
          "ui.cursorline.primary" = { bg = cursorline; };
          "ui.highlight" = {
            bg = surface1;
            modifiers = [ "bold" ];
          };
          "ui.menu" = {
            fg = overlay2;
            bg = surface0;
          };
          "ui.menu.selected" = {
            fg = text;
            bg = surface1;
            modifiers = [ "bold" ];
          };
          "diagnostic.error" = {
            underline = {
              color = red;
              style = "curl";
            };
          };
          "diagnostic.warning" = {
            underline = {
              color = yellow;
              style = "curl";
            };
          };
          "diagnostic.info" = {
            underline = {
              color = sky;
              style = "curl";
            };
          };
          "diagnostic.hint" = {
            underline = {
              color = teal;
              style = "curl";
            };
          };
          error = red;
          warning = yellow;
          info = sky;
          hint = teal;

        };
      };
    };
  };
}

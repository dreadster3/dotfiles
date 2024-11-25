accent: ''
  * {
    border: none;
    border-radius: 0;
    font-size: 13px;
    min-height: 0;
  }

  window#waybar {
    background: alpha(@background, 0.5);
    border-bottom: 1px solid;
    border-color: @mantle;
    color: @foreground;
  }

  tooltip {
    background: alpha(@background, 1);
    border: 1px solid;
    border-color: @surface1;
    border-radius: 10px;
  }
  tooltip label {
    color: @foreground;
  }

  #custom-launcher {
    font-size: 15px;
    color: @${accent};
    background-color: @background;
    border-radius: 10px;
    border-width: 1.3px;
    border-color: @surface1;
    border-style: solid;
    margin: 5px;
    padding-left: 8px;
    padding-right: 14px;
  }

  #workspaces {
    border-radius: 10px;
    margin: 5px;
    background-color: @background;
    border-width: 1.3px;
    border-color: @surface1;
    border-style: solid;
  }

  #workspaces button {
    border-radius: 10px;
    padding: 5px;
    background: transparent;
    color: @foreground;
  }

  #workspaces button.active {
    border-radius: 10px;
    color: @background;
    background: @${accent};
    padding-left: 8px;
    padding-right: 8px;
    margin: 1.5px;
  }

  #workspaces button.hover {
    border-radius: 10px;
    background: @surface2;
    margin: 1px;
  }

  #cpu {
    color: @flamingo;
    background-color: @background;
    border-radius: 10px;
    margin: 5px;
    padding: 5px;
    border-width: 1.3px;
    border-color: @surface1;
    border-style: solid;
  }

  #memory {
    color: @peach;
    background-color: @background;
    border-radius: 10px;
    margin: 5px;
    padding: 5px;
    border-width: 1.3px;
    border-color: @surface1;
    border-style: solid;
  }

  #disk {
    color: @yellow;
    background-color: @background;
    border-radius: 10px;
    margin: 5px;
    padding: 5px;
    border-width: 1.3px;
    border-color: @surface1;
    border-style: solid;
  }

  #clock {
    color: @foreground;
    background-color: @background;
    border-radius: 10px;
    margin: 5px;
    padding-left: 0px;
    padding-right: 0px;
    border-width: 1.3px;
    border-color: @surface1;
    border-style: solid;
  }

  #battery {
    background-color: @background;
    color: @green;
    border-radius: 10px;
    margin: 5px;
    padding-left: 5px;
    padding-right: 5px;
    border-width: 1.3px;
    border-color: @surface1;
    border-style: solid;
  }

  #battery.warning {
    color: @peach;
  }

  #battery.critical {
    color: @red;
  }

  #battery.charging,
  #battery.plugged {
    color: @${accent};
  }

  #backlight {
    color: @yellow;
    background-color: @background;
    border-radius: 10px;
    margin: 5px;
    padding: 5px;
    padding-left: 5px;
    padding-right: 8px;
    border-width: 1.3px;
    border-color: @surface1;
    border-style: solid;
  }

  #pulseaudio {
    color: #f5c2e7;
    background-color: @background;
    border-radius: 10px;
    margin: 5px;
    padding-left: 5px;
    padding-right: 8px;
    border-width: 1.3px;
    border-color: @surface1;
    border-style: solid;
  }

  #tray {
    background-color: @background;
    border-radius: 10px;
    margin: 5px;
    padding: 5px;
    border-width: 1.3px;
    border-color: @surface1;
    border-style: solid;
  }

  #custom-playerctl {
    background: @background;
    padding-left: 15px;
    padding-right: 14px;
    border-radius: 16px;
    border-width: 1.3px;
    border-style: solid;
    border-color: @surface1;
    /* border-left: solid 1px #ffffff; */
    /* border-right: solid 1px #ffffff; */
    margin-top: 5px;
    margin-bottom: 5px;
    margin-left: 5px;
    color: @mauve;
    font-weight: normal;
    font-style: normal;
    font-size: 16px;
  }

  #custom-playerlabel {
    background: transparent;
    padding-left: 10px;
    padding-right: 15px;
    border-radius: 16px;
    color: @mauve;
    /*border-left: solid 1px #282738;*/
    /*border-right: solid 1px #282738;*/
    margin-top: 5px;
    margin-bottom: 5px;
    font-weight: normal;
    font-style: normal;
  }
''

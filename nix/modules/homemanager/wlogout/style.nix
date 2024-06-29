{ }:
let
  lock_image = toString ./lock.png;
  lock_hover_image = toString ./lock-hover.png;
  logout_image = toString ./logout.png;
  logout_hover_image = toString ./logout-hover.png;
  suspend_image = toString ./sleep.png;
  suspend_hover_image = toString ./sleep-hover.png;
  shutdown_image = toString ./power.png;
  shutdown_hover_image = toString ./power-hover.png;
  reboot_image = toString ./restart.png;
  reboot_hover_image = toString ./restart-hover.png;

in ''
  window {
      font-family: monospace;
      font-size: 14pt;
      color: #cdd6f4; /* text */
      background-color: rgba(30, 30, 46, 0.5);
  }

  button {
      background-repeat: no-repeat;
      background-position: center;
      background-size: 25%;
      border: none;
      background-color: rgba(30, 30, 46, 0);
      margin: 5px;
      transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
  }

  button:hover {
      background-color: rgba(49, 50, 68, 0.1);
  }

  button:focus {
      background-color: #cba6f7;
      color: #1e1e2e;
  }

  #lock {
      background-image: image(url("${lock_image}"));
  }
  #lock:focus {
      background-image: image(url("${lock_hover_image}"));
  }

  #logout {
      background-image: image(url("${logout_image}"));
  }
  #logout:focus {
      background-image: image(url("${logout_hover_image}"));
  }

  #suspend {
      background-image: image(url("${suspend_image}"));
  }
  #suspend:focus {
      background-image: image(url("${suspend_hover_image}"));
  }

  #shutdown {
      background-image: image(url("${shutdown_image}"));
  }
  #shutdown:focus {
      background-image: image(url("${shutdown_hover_image}"));
  }

  #reboot {
      background-image: image(url("${reboot_image}"));
  }
  #reboot:focus {
      background-image: image(url("${reboot_hover_image}"));
  }
''

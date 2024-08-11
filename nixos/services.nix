_: {
  services = {
    # Graphics
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
    };

    displayManager = {
      autoLogin = {
        enable = true;
        user = "hushh";
      };
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    xserver.videoDrivers = [ "nvidia" ];

    # Audio
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      wireplumber = { 
        enable = true; 
        extraConfig = {
          "10-disable-camera" = {
            "wireplumber.profiles" = {
              main = {
                "monitor.libcamera" = "disabled";
              };
            };
          };
        };
      };
    };

    #misc services
    gvfs.enable = true;
    tumbler.enable = true;
    dbus.enable = true;
    gnome.gnome-keyring.enable = true;
  };
}

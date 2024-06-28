_: {
  services = {
    xserver.enable = true;
    displayManager = {
      sddm = {
        enable = true;
        autoLogin.enable = true;
        autoLogin.user = "hazaki";
        wayland.enable = false;
      };
      #defaultSession = "hyprland";
    };
  };
}

_: {
  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = false;
      };
      #defaultSession = "hyprland";
    };
  };
}

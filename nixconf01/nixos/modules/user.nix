{ pkgs, ... }: {
  programs.fish.enable = true;

  users.users.hazaki = {
    isNormalUser = true;
    description = "hazaki";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [];
  };

  # Enable automatic login for the user.
  #services.getty.autologinUser = "hazaki";
}

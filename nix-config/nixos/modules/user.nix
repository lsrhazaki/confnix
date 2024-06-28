{ pkgs, ... }: {
  
  users.users = {
    hazaki = {
      isNormalUser = true;
      description = "hazaki";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];

  # Enable automatic login for the user.
  services.getty.autologinUser = "hazaki";
}

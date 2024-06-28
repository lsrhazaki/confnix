{ lib, hostname, ... }: {
  # Hostname
  networking.hostName = "hazaki";
  networking.networkmanager.enable = true;
  networking.firewall.enable = lib.mkDefault true;

  # networking.firewall.allowedTCPPorts = [ 3000 ];
  # networking.firewall.allowedUDPPorts = [ 3000 ];
  # Or disable the firewall altogether.

  services.avahi = {
    enable = true;
    };
}
{ inputs, pkgs, config, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/packages.nix
    ./modules/bundle.nix
  ];

  disabledModules = [
    ./modules/trim.nix
    ./modules/hyprland.nix
    ./modules/bluetooth.nix
    ./modules/bootloader.nix
  ];

  # Bootloader.
  boot.loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        device = "nodev";
        efiSupport = true;
        enable = true;
        useOSProber = true;
       };  
     };

  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.overlays = [ ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enabling flakes

  system.stateVersion = "24.05"; # State Version.
}

{ pkgs, ... }:

{
  boot ={
    kernelPackages = pkgs.linuxPackages_latest;       # Get latest kernel
    #initrd.kernelModules = ["amdgpu"];                # More on this later on (setting it for xserver)
    loader = {
      efi = {
        canTouchEfiVariables = true;
        #efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 5;                       # Limit stored system configurations.
      };                                              # Also exists for systemd-boot
      timeout = 5;                                    # Work for grub and efi boot, time before auto-boot
    };
  };
}
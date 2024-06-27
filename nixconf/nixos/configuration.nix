# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
    ];

  nixpkgs = {
    # You can add overlays here
    overlays = [ ];
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    # Enable AutoCleaning.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };
  };    

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

  # Hostname
  networking.hostName = "nixsaiga"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_PH.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fil_PH";
    LC_IDENTIFICATION = "fil_PH";
    LC_MEASUREMENT = "fil_PH";
    LC_MONETARY = "fil_PH";
    LC_NAME = "fil_PH";
    LC_NUMERIC = "fil_PH";
    LC_PAPER = "fil_PH";
    LC_TELEPHONE = "fil_PH";
    LC_TIME = "fil_PH";
  };
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Enable the leftwm.
  services.displayManager.sddm.enable = true;
  services.xserver.windowManager.leftwm.enable = true;
    
  # Hardware. 
    hardware.opengl.driSupport32Bit = true;

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Avahi
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "ph";
    xkb.variant = "";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hazaki = {
    isNormalUser = true;
    description = "hazaki";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = let
      authorizedKeys = pkgs.fetchurl {
        url = " https://github.com/lsrhazaki.keys ";
        sha256 = " mqRGmV6MeK6vzKkU5R+6SlaC/uzN2cSL4xwsWSTvL/M ";
      };
    in pkgs.lib.splitString "\n" (builtins.readFile
    authorizedKeys);
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "hazaki";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };

  services.gvfs.enable = true;

  services.tumbler.enable = true;
  programs.xfconf.enable = true;
  programs.dconf.enable = true;
  programs.fish.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
    PasswordAuthentication = true;
  };
};

  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g
  system.stateVersion = "24.05"; # Did you read the comment?

}

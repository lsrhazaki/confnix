{ pkgs, ... }:

{

  security.polkit.enable = true;

  # Services
  services.gvfs.enable = true;
  services.mpd.enable = true;
  services.tumbler.enable = true; 
  services.dbus.enable = true;
  services.dbus.packages = with pkgs; [
  	xfce.xfconf
  	gnome2.GConf
  ];

  # Programs
  programs.xfconf.enable = true;
  programs.direnv.enable = true;
  programs.dconf.enable = true;
  programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };
}
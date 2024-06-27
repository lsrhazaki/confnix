{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["openssl-1.1.1u"];
  };

  environment.systemPackages = with pkgs; [
     # Terminal coms.
     zip
     inxi
     btop
     wget
     unzip
     killall
     lazygit
     hwinfo
     glxinfo
     pciutils
     alacritty
     
    # Desktop apps
     feh
     mpv
     arandr
     heroic
     firefox
     discord
     galculator
     winetricks
     qbittorrent
     xfce.mousepad
     lxqt.lxqt-policykit
     wineWowPackages.stable

    # Coding stuff
    gnumake
    gcc
    lazygit
    stylua
    fd
    sumneko-lua-language-server
    ripgrep

    # Screenshotting
    slurp
    flameshot
    swappy
];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}

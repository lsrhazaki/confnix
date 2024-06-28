{

  imports = [
    ./fish.nix
    ./modules/bundle.nix
    #./zsh.nix
  ];

  home = {
    username = "hazaki";
    homeDirectory = "/home/hazaki";
    stateVersion = "24.05";
  };
}

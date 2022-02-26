{ pkgs, ...}: {
  home.packages = [ 
    pkgs.git 
    pkgs.zsh 
    pkgs.alacritty 
    pkgs.firefox 
    pkgs.brave] ;
}


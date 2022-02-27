{ pkgs, ...}: {

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true ;
  };

  home.packages = [ 
    pkgs.zsh 
    pkgs.alacritty 
    pkgs.firefox 
    pkgs.brave
    pkgs.swaylock
    pkgs.swayidle
    pkgs.wl-clipboard
    pkgs.mako
    pkgs.wofi
  ] ;

  programs.git = {
    enable = true;
    userName = "Matt Rixman";
    userEmail = "MatrixManAtYrService@users.noreply.github.com";
    extraConfig = {
      core = {
        editor = "nvim";
      };
    };
  };

}


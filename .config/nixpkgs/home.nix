{ pkgs, ...}: {
  home.packages = [ 
    pkgs.zsh 
    pkgs.alacritty 
    pkgs.firefox 
    pkgs.brave] ;

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


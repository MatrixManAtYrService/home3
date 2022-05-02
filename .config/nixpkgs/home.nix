{ pkgs, ...}: {

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [ 
    zsh 
    alacritty 
    firefox 
    google-chrome
    brave
    swaylock
    swayidle
    kanshi
    wl-clipboard
    mako
    wofi
    wlsunset
    swaylock
    swayidle
    wl-clipboard
    mako
    python39Packages.ipython
    python39Packages.flake8
    python310
    black
    slack
    vscode
    htop
  ] ;

  home.shellAliases = {
    vi = "nvim";
  };


  # IPython vi-mode
  home.file.".ipython/profile_default/ipython_config.py".text = ''
  c.TerminalInteractiveShell.editing_mode = 'vi'
  '';

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

  services.wlsunset = {
    enable = true;
    longitude = "-104.80";
    latitude = "38.83";
  };

  home.file.".config/Code/User/settings.json".text = ''
  {
    "workbench.startupEditor": "welcomePage",
    "editor.formatOnSave": true,
    "terminal.integrated.scrollback": 100000,
    "files.exclude": {
      "**/__pycache__": true,
      "**/.eggs": true,
      "**/.pytest_cache": true,
      "**/*.egg-info": true
    },
    "[yaml]": {
      "editor.autoIndent": "advanced"
    },
    "python.flake8Args": [
      "--max-line-length=120",
      "--ignore=E402,E302,E305,E266,W503,E127,E241,E128,E201,E203,E202,F811,E501"
    ],
    "python.flake8Path": [
      "/home/matt/.nix-profile/bin/flake8"
    ],
    "python.formatting.provider": "black",
    "python.formatting.blackPath": "/home/matt/.nix-profile/bin/black",
    "python.analysis.logLevel": "Trace",
  }
  '';

}

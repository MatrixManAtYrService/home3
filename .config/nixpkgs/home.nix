{ pkgs, ...}: 
{


  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "18.09";


  home.packages = with pkgs; [ 
    zsh 
    exercism
    silver-searcher
    alacritty 
    asciinema
    kitty
    firefox 
    fortune
    google-chrome
    brave
    kanshi
    wl-clipboard
    mako
    wofi
    wlsunset
    swaylock
    swayidle
    wl-clipboard
    mako
    gimp
    gron
    gcc
    pre-commit
    python39Packages.ipython
    python39Packages.flake8
    python39Packages.pipx
    python39Packages.pandas
    python39
    postgresql
    black
    slack
    vscode
    htop
    nodejs
    minikube
    kubectl
    kubernetes-helm
    k9s
    wl-clipboard
    gnome.nautilus
    vlc
    graphviz
    yarn
    lsof
    sqlite
    grim
    slurp
    terraform
    awscli
    docker-compose
    bat
    tmux
  ] ;

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    jq.enable = true;
    dircolors.enable = true;
    htop.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    plugins = [
      {
        name = "pure";
        src = pkgs.fetchFromGitHub {
          owner = "sindresorhus";
  	repo = "pure";
  	rev  = "v1.20.1";
  	sha256 = "1bxg5i3a0dm5ifj67ari684p89bcr1kjjh6d5gm46yxyiz9f5qla";
        };
      }
      {
        name = "today";
        src = ./zsh_functions;
        file = "today.zsh";
      }
      {
        name = "vi-zle-customizations";
        src = ./zsh_functions;
        file = "vi-zle.zsh";
      }
    ];
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins;
      let
        vim-nix = pkgs.vimUtils.buildVimPlugin {
          name = "vim-nix";
          src = pkgs.fetchgit {
	    url = "https://github.com/LnL7/vim-nix";
            rev = "7d23e97d13c40fcc6d603b291fe9b6e5f92516ee";
	    sha256 = "1vaprm79j0nfl37r6lw0zwd048ajd5sc9cvny59qwdl3x0zk38av";
          };
        };
      in [
        vim-nix
        pkgs.vimPlugins.coc-nvim
        pkgs.vimPlugins.coc-json
        pkgs.vimPlugins.coc-pyright
        # todo: try coc-pylsp
        pkgs.vimPlugins.fzf-vim
        pkgs.vimPlugins.vim-isort
      ];
      extraConfig = ''
        " fzf
        """""

        nnoremap <silent> <C-p> :GFiles<CR>

        " black
        """""""

        "autocmd BufWritePost *.py execute '! black %'

        " coc
        """""

        inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
        inoremap <silent><expr> <cr> "\<c-g>u\<CR>"
      '';
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


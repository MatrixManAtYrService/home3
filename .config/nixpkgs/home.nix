{ pkgs, ...}: 
{


  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "18.09";

  nixpkgs.overlays = [
    (self: super: {
      fcitx-engines = pkgs.fcitx5;
    })
  ];


  home.packages = with pkgs; [ 
    yamlfmt
    yaml-language-server
    cwltool
    helix
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
    python310Packages.ipython
    python310Packages.python-lsp-server
    python310Packages.black
    python310Packages.flake8
    python310
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
    nimlsp
    microsoft-edge
    icdiff
    tree
    ruff
    tcpdump
    mitmproxy
    cachix
    wget
    boinc
    wezterm
    gparted
    cmake
    gnumake
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
        copilot-vim = pkgs.vimUtils.buildVimPlugin {
          name = "copilot-vim";
          src = pkgs.fetchgit {
	    url = "https://github.com/github/copilot.vim";
            rev = "9e869d29e62e36b7eb6fb238a4ca6a6237e7d78b";
	    sha256 = "B+2hHNTrabj6O9F6OoskNIUsjJXLrt+4XgjuiRoM80s=";
          };
        };
        nim-vim = pkgs.vimUtils.buildVimPlugin {
          name = "nim-vim";
          src = pkgs.fetchgit {
	    url = "https://github.com/zah/nim.vim";
            rev = "a15714fea392b0f06ff2b282921a68c7033e39a2";
	    sha256 = "B+2hHNTrabj6O9F6OoskNIUsjJXLrt+4XgjuiRoM80s=";
          };
        };
        asyncomplete-vim = pkgs.vimUtils.buildVimPlugin {
          name = "asyncomplete-vim";
          src = pkgs.fetchgit {
	    url = "https://github.com/prabirshrestha/asyncomplete.vim";
            rev = "9c7651894c2c6d656c0dc71e87cfabbbb71b9c78";
	    sha256 = "G9KLPyVatLC3eLeUMFpppFdD4SroUzbZ2sdam3aISu4=";
          };
        };
        async-vim = pkgs.vimUtils.buildVimPlugin {
          name = "async-vim";
          src = pkgs.fetchgit {
	    url = "https://github.com/prabirshrestha/async.vim";
            rev = "2082d13bb195f3203d41a308b89417426a7deca1";
	    sha256 = "YxZdOpV66YxNBACZRPugpk09+h42Sx/kjjDYPnOmqyI=";
          };
        };
        asyncomplete-lsp-vim = pkgs.vimUtils.buildVimPlugin {
          name = "asyncomplete-lsp-vim";
          src = pkgs.fetchgit {
	    url = "https://github.com/prabirshrestha/asyncomplete-lsp.vim";
            rev = "cc5247bc268fb2c79d8b127bd772514554efb3ee";
	    sha256 = "SeEAy/jtrdHerZPVjQZXANTcuvMndIIWgGh3B8Ik1NM=";
          };
        };
      in [
        vim-nix
        #copilot-vim

        ## nim-lsp
        #pkgs.vimPlugins.vim-lsp
        #asyncomplete-vim
        #async-vim
        #asyncomplete-lsp-vim

        ## pkgs.vimPlugins.nim-vim
        #pkgs.vimPlugins.coc-nvim
        #pkgs.vimPlugins.coc-json
        #pkgs.vimPlugins.coc-pyright
        ## todo: try coc-pylsp
        #pkgs.vimPlugins.fzf-vim
        #pkgs.vimPlugins.vim-isort
      ];
      #extraConfig = ''
      #  " fzf
      #  """""

      #  nnoremap <silent> <C-p> :GFiles<CR>

      #  " black
      #  """""""

      #  "autocmd BufWritePost *.py execute '! black %'

      #  " coc
      #  """""

      #  inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
      #  inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

      #  " nimlsp
      #  """""""""
      #  let s:nimlspexecutable = "nimlsp"
      #  let g:lsp_log_verbose = 1
      #  let g:lsp_log_file = expand('/tmp/vim-lsp.log')
      #  " for asyncomplete.vim log
      #  let g:asyncomplete_log_file = expand('/tmp/asyncomplete.log')

      #  let g:asyncomplete_auto_popup = 0

      #  if has('win32')
      #     let s:nimlspexecutable = "nimlsp.cmd"
      #     " Windows has no /tmp directory, but has $TEMP environment variable
      #     let g:lsp_log_file = expand('$TEMP/vim-lsp.log')
      #     let g:asyncomplete_log_file = expand('$TEMP/asyncomplete.log')
      #  endif
      #  if executable(s:nimlspexecutable)
      #     au User lsp_setup call lsp#register_server({
      #     \ 'name': 'nimlsp',
      #     \ 'cmd': {server_info->[s:nimlspexecutable]},
      #     \ 'whitelist': ['nim'],
      #     \ })
      #  endif

      #  function! s:check_back_space() abort
      #      let col = col('.') - 1
      #      return !col || getline('.')[col - 1]  =~ '\s'
      #  endfunction

      #  inoremap <silent><expr> <TAB>
      #    \ pumvisible() ? "\<C-n>" :
      #    \ <SID>check_back_space() ? "\<TAB>" :
      #    \ asyncomplete#force_refresh()
      #  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
      #
      #'';
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


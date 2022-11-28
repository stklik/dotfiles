{ config, pkgs, lib, ... }:
let
  bash_profile_content =
    ''
    # Load the shell dotfiles, and then some:
    # * ~/.paths can be used to extend `$PATH`.
    # * ~/.extra can be used for other settings you don’t want to commit.
    for file in ~/.{paths,aliases,exports,functions,extra}; do
      [ -r "$file" ] && [ -f "$file" ] && source "$file";
    done;
    unset file;
    '';
in {
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    # username = "stefan";
    # homeDirectory = "/Users/stefan";

    # symlink all dotfiles !
    file = {
      ".aliases".source = ./.aliases;
      ".exports".source = ./.exports;
      ".functions".source = ./.functions;
      ".paths".source = ./.paths;

      ".finicky.js".source = ./.finicky.js;  # only interesting on Mac...
      ".tmux.conf".source = ./.tmux.conf;
      ".vimrc".source = ./.vimrc;
    };

    # No-config packages to install
    packages = with pkgs; [
      comma
      curl
      gitAndTools.delta
      graphviz
      openssl_3_0
      pssh
      rsync
      tldr
      tmux
      tree
      wget
      zsh-z
    ] ++ lib.optionals stdenv.isDarwin [
      m-cli
      mas
    ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  stateVersion = "22.05";

  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    bat.enable = true;

    bash = {
      enable = true;
      bashrcExtra =
        ''
        # dotfiles loading
        source ~/.bash_profile;
        '';
      profileExtra = bash_profile_content;
    };

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    git = {
      enable = true;
      userName = "Stefan Klikovits";
      userEmail = "stefan@klikovits.net";
      ignores = [
        ".DS_Store"
        "**/.DS_Store"
        ".AppleDouble"
        ".LSOverride"
        "*.niu"
        ".local"

        # --- From Stefan's .gitconfig --- #
        # Folder view configuration files
        "Desktop.ini"

        # Thumbnail cache files
        "._*"
        "Thumbs.db"

        # Files that might appear on external disks
        ".Spotlight-V100"
        ".Trashes"

        # Always-ignore extensions
        "*~"
        "*.diff"
        "*.err"
        "*.log"
        "*.orig"
        "*.pyc"
        "*.rej"
        "*.sass-cache"
        "*.sw?"
        "*.vi"
      ];
      aliases = {};
      extraConfig = {
        # core.pager = "diff-so-fancy | less --tabs=1,5 -R";
        core.pager = "delta";
        core.editor = "vim";
        submodule.recurse = "true";
        delta.features = "side-by-side line-numbers";
        github.user = "stklik";
        init.defaultBranch = "main";
        pull.rebase = "false";
      };

    };

    htop.enable = true;
    htop.settings.show_program_path = true;

    jq.enable = true;

    # NOTE: Extra config from dotfile!
    tmux = {
      enable = true;
      baseIndex = 1;
      historyLimit = 102400;

    };

    # NOTE: Extra config from dotfile!
    vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-sensible
        nerdtree
        nerdtree-git-plugin
        vim-fugitive
        vim-gitgutter
        vim-airline
        vim-airline-themes
        vim-colors-solarized
        vim-surround
        vimtex
        indentLine
      ];
      settings = {
        background = "dark";

        backupdir = [ "~/.vim/backups" ];
        directory = [ "~/.vim/swaps" ];
        undodir = [ "~/.vim/undo" ];

        expandtab = true;
        ignorecase = true;
        mouse = "a";
        number = true;
        relativenumber = true;
        shiftwidth = 4;
        tabstop = 4;
      };
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      autocd = true;

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "direnv" "docker" "extract" "gitignore" "pip" "python" "transfer" "z"
	];
      };

      initExtra = bash_profile_content;
    };
  };

}

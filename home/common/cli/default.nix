{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./neovim
    ./zsh
  ];

  home.packages = with pkgs; [
    (pkgs.nerdfonts.override {fonts = ["Hack"];})
  ];

  programs = {
    alacritty = {
      enable = true;
      settings = {
        general.import = [
          "${pkgs.alacritty-theme}/catppuccin_macchiato.toml"
        ];
      };
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      userName = "prophetarmed";
      userEmail = "me@prophetarmed.com";
    };
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
    tmux = {
      enable = true;
      terminal = "tmux-256color";
      baseIndex = 1;
      historyLimit = 100000;
      mouse = true;
      prefix = "C-a";
      plugins = with pkgs; [
        tmuxPlugins.better-mouse-mode
        tmuxPlugins.sensible
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = "set -g @catppuccin_flavor 'macchiato'";
        }
      ];
      extraConfig = ''
        set-option -sa terminal-overrides ",alacritty*:Tc"

        bind-key -n M-! select-window -t 1
        bind-key -n M-@ select-window -t 2
        bind-key -n M-# select-window -t 3
        bind-key -n M-$ select-window -t 4
        bind-key -n M-% select-window -t 5
        bind-key -n M-^ select-window -t 6
        bind-key -n M-& select-window -t 7
        bind-key -n M-* select-window -t 8
        bind-key -n M-( select-window -t 9
        bind-key -n M-) select-window -t 0
      '';
    };
  };
}

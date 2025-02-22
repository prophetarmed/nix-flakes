{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji

    prismlauncher
    spotify
    vesktop
  ];

  programs = {
    firefox.enable = true;
  };
}

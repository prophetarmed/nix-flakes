{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;
    functions = {
      last_history_item = "echo $history[1]";
    };

    interactiveShellInit = ''
      set fish_greeting
      abbr -a !! --position anywhere --function last_history_item
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';

    shellAliases = {
      darwinRebuild = "sudo darwin-rebuild switch --flake .#";
      nixosRebuild = "sudo nixos-rebuild switch --flake .#";
      nixosUpdate = "sudo nixos-rebuild switch --recreate-lock-file --flake .";
    };

    plugins = with pkgs; [
    ];
  };
}

{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ./hardware-configuration.nix
  ];

  boot.kernelParams = ["quiet" "splash"];
  hardware.cpu.amd.updateMicrocode = true;

  fileSystems."/mnt/Secondary" = {
    device = "/dev/disk/by-uuid/8c90e68f-97a2-4c14-beae-5336580091a8";
    fsType = "ext4";
  };

  fileSystems."/mnt/Others" = {
    device = "/dev/disk/by-uuid/46f52cad-7ff3-41aa-ae67-f1fd344784b7";
    fsType = "ext4";
  };

  networking.hostName = "leon";

  programs.dconf.enable = true;
  security.polkit.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications" "/share/zsh"];

  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    dataDir = "/home/user";
    configDir = "/home/user/.config/syncthing";
    user = "user";
    group = "users";
    declarative = {
      overrideDevices = true;
      overrideFolders = true;
      devices = {
        #"coredns-server" = { id = "REALLY-LONG-COREDNS-SERVER-SYNCTHING-KEY-HERE"; };
      };
      folders = {
        "Obsidian" = {
          path = "/home/user/Documents/Obsidian";
          #devices = [ "laptop" ];
          versioning = {
            type = "simple";
          };
        };
      };
    };
  };

  system.stateVersion = "24.11";
}

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

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
    "dotnet-runtime-6.0.36"
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  services.syncthing = {
    enable = true;
    dataDir = "/home/user/Documents";
    #openDefaultPorts = true;
    configDir = "/home/user/.config/syncthing";
    user = "user";
    group = "users";
    guiAddress = "0.0.0.0:8384";
    declarative = {
      overrideDevices = true;
      overrideFolders = true;
      devices = {
        "aiko" = {id = "UW32GUQ-YS2BZLZ-F4II4TS-ENYYO74-HQLHZGB-CBE5K74-I6XALAT-I3ZPVAO";};
        "phone" = {id = "QARPS3W-IKYPFPP-LGN2CWQ-LJFMN36-RDYFFPN-CKTP7RD-3EQ6Y64-Z3IKDAR";};
      };
      folders = {
        "Org" = {
          path = "/home/user/Documents/Org";
          devices = [
            "aiko"
            "phone"
          ];
          versioning = {
            type = "simple";
            params = {
              keep = "10";
            };
          };
        };
      };
    };
  };

  system.stateVersion = "24.11";
}

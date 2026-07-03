{ inputs, self, ... }:
{
  flake.nixosConfigurations.wignesh = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostWignesh
    ];
  };

  flake.nixosModules.hostWignesh = {
    imports = [
      inputs.home-manager.nixosModules.default
      inputs.nixos-hardware.nixosModules.asus-zephyrus-gu603h

      self.nixosModules.common-bundle
      self.nixosModules.user

      self.nixosModules.hyprland
      self.nixosModules.niri
      self.nixosModules.cloudflare-warp
      self.nixosModules.bluetooth
      # self.nixosModules.btrfs
      self.nixosModules.nvidia
      self.nixosModules.sleep

      self.nixosModules.plymouth
      self.nixosModules.stylix

      self.nixosModules.avahi
      self.nixosModules.docker
      # self.nixosModules.tailscale
      self.nixosModules.printing

      # self.nixosModules.automatic-timezone
      self.nixosModules.locale
      self.nixosModules.battery
      # self.nixosModules.secure-boot
      self.nixosModules.systemd-boot
      self.nixosModules.gnome
    ];

    preferences = {
      user = {
        name = "wignesh";
        extraGroups = [
          "networkmanager"
          "wheel"
          "dialout"
        ];
        useSopsPassword = false;
      };
      # secure-boot.wait-for-network = false;
      boot.wait-for-network = false;
    };

    home-manager = {
      users.wignesh = self.homeModules.wignesh-wignesh;
      useUserPackages = true;
      useGlobalPkgs = true;
    };

    networking.hostName = "wignesh";
    system.stateVersion = "26.05";
  };
}

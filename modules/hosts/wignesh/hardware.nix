{
  flake.nixosModules.hostWignesh =
  { config, lib, pkgs, modulesPath, ... }:

  {
    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/bc86369f-2ee2-490a-a2de-3a20d39c9b19";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/BD8E-FA62";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    networking.useDHCP = lib.mkDefault true;

    hardware = {
      bluetooth.enable = lib.mkDefault true;
    };
  };
}

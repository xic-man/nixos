# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5718d476-73d2-4192-a78a-73915b4bdc88";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-d7611f1f-6e0e-4a3f-bb88-f7bf4500c5b6".device = "/dev/disk/by-uuid/d7611f1f-6e0e-4a3f-bb88-f7bf4500c5b6";

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/B9B6-4E62";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/739ff243-4526-4b48-ad5e-1a3461fa8421"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s13f0u4u1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp166s0.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

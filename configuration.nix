{ config, pkgs, ... }:

{
  # Version
  system.stateVersion = "22.11";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
#  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.lib.attrsets.recurseIntoAttrs (pkgs.linuxPackagesFor pkgs.linuxKernel.kernels.linux_testing);

  # Keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Swap
  boot.initrd.luks.devices."luks-04d386b9-feeb-4e7a-8963-b16b9325c2f9".device = "/dev/disk/by-uuid/04d386b9-feeb-4e7a-8963-b16b9325c2f9";
  boot.initrd.luks.devices."luks-04d386b9-feeb-4e7a-8963-b16b9325c2f9".keyFile = "/crypto_keyfile.bin";

  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = "xic-framework";

  # Localisation
  time.timeZone = "Australia/Melbourne";
  i18n.defaultLocale = "en_AU.utf8";

  # Desktop
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    layout = "au";
    xkbVariant = "";

    libinput = {
      enable = true;

      mouse = {
        accelProfile = "flat";
      };

      touchpad = {
        accelProfile = "flat";
        tapping = true;
      };
    };
  };

  # Printing
  services.printing.enable = true;

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # System packages
  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;
  services.gnome.core-utilities.enable = false;
  environment.systemPackages = with pkgs; [
    gnome.gnome-shell
    gnome.gnome-session
    gnome.nautilus
  ];
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
  ];
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];
  services.fwupd.enable = true;
}

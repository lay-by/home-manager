# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6dfafd15-d95c-4d36-9c8e-78d6cde948d4";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-986587d7-950f-4862-8ea8-68dfbe56f316".device =
    "/dev/disk/by-uuid/986587d7-950f-4862-8ea8-68dfbe56f316";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/652A-DDB8";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  fileSystems."/media/HDD" = {
    device = "/dev/disk/by-uuid/6d60675c-ebe6-4f7f-b9bc-be9cdc748c90";
    fsType = "btrfs";
  };

  # For some reason this piece of shit makes my pc freeze at high ram utilization.   
  #swapDevices = [ {
  #  device = "/var/lib/swapfile";
  #  size = 16*1024;
  #  randomEncryption.enable = true; 
  #} ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp27s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

}

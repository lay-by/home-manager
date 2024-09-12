{
  pkgs,
  lib,
  config,
  ...
}:
{
  hardware = {
    graphics = {
      enable = true;
      # For Wine32 mostly
      enable32Bit = true;
      extraPackages = lib.attrValues {
        inherit (pkgs)
          mesa
          nvidia-vaapi-driver
          # For Encoding/Decoding Videos
          nv-codec-headers-12
          vulkan-loader
          ;
      };
      extraPackages32 = lib.attrValues { inherit (pkgs.driversi686Linux) mesa; };
    };

    nvidia = {
      open = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
}

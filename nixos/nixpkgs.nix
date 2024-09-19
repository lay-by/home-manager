{ lib, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      # causing opencv to fail build
      #cudaSupport = true;
      packageOverrides = pkgs: {
        steam = pkgs.steam.override {
          # The extraPkgs attribute expects a function that takes a package set (p)
          # and returns a list of packages. We use lib.attrValues to convert the
          # attribute set to a list of package values.
          # https://github.com/NixOS/nixpkgs/blob/fc27807b85986bb26a8f28e590e01fae742e6b53/pkgs/games/steam/fhsenv.nix#L3
          extraPkgs =
            p:
            lib.attrValues {
              inherit (pkgs.xorg)
                libXcursor
                libXi
                libXinerama
                libXScrnSaver
                ;

              inherit (pkgs)
                libpng
                libpulseaudio
                libvorbis
                libkrb5
                keyutils
                mono
                gtk3
                gtk3-x11
                libgdiplus
                zlib
                ;

              inherit (pkgs.stdenv.cc.cc) lib;
            };
        };
      };
    };
  };
}

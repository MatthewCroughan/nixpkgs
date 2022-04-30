# To build, use:
# nix-build nixos -I nixos-config=nixos/modules/installer/sd-card/sd-image-riscv64-visionfive.nix -A config.system.build.sdImage
{ config, lib, pkgs, ... }:

{
  imports = [
    ../../profiles/base.nix
    ./sd-image.nix
  ];

  hardware.deviceTree.name = "starfive/jh7100-starfive-visionfive-v1.dtb";
  systemd.services."serial-getty@hvc0".enable = false;
  environment.systemPackages = with pkgs; [ mtdutils ];

  boot = {
    consoleLogLevel = lib.mkDefault 7;
    kernelPackages = pkgs.linuxPackages_visionfive;

    kernelParams = [
      "console=tty0"
      "console=ttyS0,115200n8"
      "earlycon=sbi"
    ];

    initrd.kernelModules = [
      "dw-axi-dmac-platform"
      "dw_mmc-pltfm"
      "spi-dw-mmio"
    ];

    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  sdImage = {
    imageName = "${config.sdImage.imageBaseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}-visionfive.img";

    # We have to use custom boot firmware since we do not support
    # StarFive's Fedora MMC partition layout. Thus, we include this in
    # the image's firmware partition so the user can flash the custom firmware.
    populateFirmwareCommands = ''
      cp ${pkgs.firmware-visionfive}/opensbi_u-boot_visionfive.bin firmware/opensbi_u-boot_visionfive.bin
    '';

    populateRootCommands = ''
      mkdir -p ./files/boot
      ${config.boot.loader.generic-extlinux-compatible.populateCmd} -c ${config.system.build.toplevel} -d ./files/boot
    '';
  };
}

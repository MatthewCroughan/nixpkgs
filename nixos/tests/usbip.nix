# modprobe usbip-host
#
# usbipd -D
#
# usbip bind -b 2-1

{ pkgs, ... }:
let
  emptyImage = pkgs.runCommand "qemu-test.img" {} ''
    ${pkgs.qemu}/bin/qemu-img create -f raw $out 512K
  '';
in
{
  name = "usbip";
  meta = with pkgs.lib.maintainers; {
    maintainers = [ matthewcroughan ];
  };

  nodes = {
    guest =
      { config, pkgs, ... }:
      {
        boot.kernelModules = [ "usbip-host" ];
        environment.systemPackages = [
          pkgs.linuxPackages.usbip
          pkgs.usbutils
        ];
        virtualisation = {
          qemu.options = [
        "-device"
        "usb-ehci"
        "-drive"
        "id=usbdisk,file=${emptyImage},if=none,readonly"
        "-device"
        "usb-storage,drive=usbdisk"
      ];
#          qemu.options = [
#            "-drive if=none,id=usbstick,format=raw,file=${emptyImage}/test.img"
#            "-usb"
#            "-device usb-ehci,id=ehci"
#            "-device usb-tablet,bus=usb-bus.0"
#            "-device usb-storage,bus=ehci.0,drive=usbstick"
##            "-device qemu-xhci"
##            "-device usb-host,vendorid=0x16c0,productid=0x05df"
##            "-device usb-storage,bus=xhci.0,drive=usbstick"
##            "-drive if=none,id=usbstick,format=raw,file=${emptyImage}"
#          ];
          forwardPorts = [
            { from = "host"; host.port = 3240; guest.port = 3240; }
          ];
        };
        networking.firewall.allowedTCPPorts = [
          3240
        ];
      };
  };

  testScript = ''
    start_all()
    guest.wait_for_unit("multi-user.target")
  '';
}

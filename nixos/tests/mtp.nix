import ./make-test-python.nix ({ pkgs, ... }: {
  name = "mtp";
  meta = with pkgs.lib.maintainers; {
    maintainers = [ matthewcroughan ];
  };

  nodes = {
    client = { config, pkgs, ... }: {
      environment.systemPackages = [ pkgs.usbutils];
      services.gvfs.enable = true;
      virtualisation.memorySize = 1024;
      virtualisation.qemu.options = [ "-usb -device usb-mtp,x-root=usbdrive,desc=mtp-share" ];
    };
  };

  testScript = ''
    start_all()
    client.wait_for_unit("multi-user.target")
    client.succeed >&2
  '';
})

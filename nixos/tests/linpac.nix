import ./make-test-python.nix ({ pkgs, ... }: {
  name = "linpac";
  meta = with pkgs.lib.maintainers; {
    maintainers = [ matthewcroughan ];
  };

  nodes = {
    machine = { config, pkgs, ... }: {
      boot.kernelModules = [ "ax25" ];
      environment.systemPackages = [ pkgs.linpac ];
      # https://www.febo.com/packet/linux-ax25/ax25-config.html
      environment.etc."ax25/axports".text = ''
        # name callsign speed paclen window description
        scc0 W8APR-13 - 255 3 145.61 MHz (1200 bps)
      '';
      boot.kernelPatches = [
        {
          name = "ax25";
          extraConfig = ''
            HAMRADIO y
            AX25 m
          '';
          patch = null;
        }
      ];
    };
  };

  testScript = ''
    start_all()
    machine.wait_for_unit("multi-user.target")
    machine.succeed("sleep infinity")
  '';
})

{ lib
, fetchFromGitHub
, buildLinux
, ... } @ args:

let
  modDirVersion = "5.17.7";
in buildLinux (args // {
  inherit modDirVersion;
  version = "${modDirVersion}-visionfive";

  src = fetchFromGitHub {
    owner = "starfive-tech";
    repo = "linux";
    rev = "f4a66b4394b13a30e9eec4dfc651f16fce285e2b";
    sha256 = "14h1q0ssigaw70a1i08xpinbspcrk7dhbk7z2xhmrii0v89a5y8r";
  };

  defconfig = "starfive_jh7100_fedora_defconfig";

  structuredExtraConfig = with lib.kernel; {
    SERIAL_8250_DW = yes;
    PINCTRL_STARFIVE = yes;

    # Doesn't build as a module
    DW_AXI_DMAC_STARFIVE = yes;

    # stmmac hangs when built as a module
    PTP_1588_CLOCK = yes;
    STMMAC_ETH = yes;
    STMMAC_PCI = yes;
  };

  extraMeta = {
    branch = "visionfive-5.17.y";
    maintainers = with lib.maintainers; [ Madouura zhaofengli ius ];
    description = "Linux kernel for StarFive's JH7100 RISC-V SoC (VisionFive)";
    platforms = [ "riscv64-linux" ];
    hydraPlatforms = [ "riscv64-linux" ];
  };
} // (args.argsOverride or { }))

{ fetchzip }:

fetchzip {
  name = "libguestfs-appliance-1.40.1";
  url = "https://web.archive.org/web/20230826201338if_/https://download.libguestfs.org/binaries/appliance/appliance-1.40.1.tar.xz";
  sha256 = "sha256-lXZwlveEWcQc5rKCUzPLJKFNgT+XK8TNZqVcBGodBgE=";

  meta = {
    hydraPlatforms = []; # Hydra fails with "Output limit exceeded"
  };
}

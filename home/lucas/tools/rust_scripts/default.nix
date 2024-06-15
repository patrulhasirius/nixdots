{pkgs, ...}: {
  home.packages = [
    (pkgs.callPackage ../../../../pkgs/catsay/default.nix {})
    (pkgs.callPackage ../../../../pkgs/ran_name/default.nix {})
    (pkgs.callPackage ../../../../pkgs/r_l/default.nix {})
    (pkgs.callPackage ../../../../pkgs/clean_uau/default.nix {})
    (pkgs.callPackage ../../../../pkgs/rejeitados/default.nix {})
  ];
}

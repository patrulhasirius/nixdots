{
  inputs,
  pkgs,
  ...
}: {
  home = {
    username = "lucas";
    homeDirectory = "/home/lucas";
    stateVersion = "24.05";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
  };

  # Imports
  imports = [
    ./apps
    ./cli-apps
    ./desktop
    ./rice
    ./system
    ./tools
    # ./virtualization
  ];

  # Allow unfree packages + use overlays
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = with inputs; [
      (
        final: prev: {
          sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation {
            pname = "sf-mono-liga-bin";
            version = "dev";
            src = sf-mono-liga-src;
            dontConfigure = true;
            installPhase = ''
              mkdir -p $out/share/fonts/opentype
              cp -R $src/*.otf $out/share/fonts/opentype/
            '';
          };

          monolisa-script = prev.stdenvNoCC.mkDerivation {
            pname = "monolisa";
            version = "dev";
            src = monolisa-script;
            dontConfigure = true;
            installPhase = ''
              mkdir -p $out/share/fonts/opentype
              cp -R $src/*.ttf $out/share/fonts/opentype/
            '';
          };

          berkeley = prev.stdenvNoCC.mkDerivation {
            pname = "berkeley-mono";
            version = "dev";
            src = berkeley;
            dontConfigure = true;
            installPhase = ''
              mkdir -p $out/share/fonts/opentype
              cp -R $src/*.otf $out/share/fonts/opentype/
            '';
          };
        }
      )
    ];
  };

  # Add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = ["thunar.desktop"];
      "image/jpeg" = ["org.kde.gwenview.desktop"];
      "image/jpg" = ["org.kde.gwenview.desktop"];
      "image/png" = ["org.kde.gwenview.desktop"];
      "text/plain" = ["org.xfce.mousepad.desktop"];
    };
  };
}

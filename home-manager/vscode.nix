
{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      mkhl.direnv
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
      christian-kohler.path-intellisense
      tamasfe.even-better-toml
    ];
  };
}
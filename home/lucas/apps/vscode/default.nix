{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
      eamodio.gitlens
      file-icons.file-icons
      dracula-theme.theme-dracula
      jnoortheen.nix-ide
      ms-python.python
      ms-toolsai.jupyter
      antfu.icons-carbon
      matklad.rust-analyzer
      file-icons.file-icons
      kamikillerto.vscode-colorize
      mechatroner.rainbow-csv
      donjayamanne.githistory
      davidanson.vscode-markdownlint
      bbenoist.nix
      charliermarsh.ruff
    ];
  };
}

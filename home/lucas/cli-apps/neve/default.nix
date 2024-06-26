{
  inputs,
  pkgs,
  Neve,
  ...
}: {
  home.packages = with pkgs; [
    inputs.Neve.packages.${system}.default
    lazygit
    stylua
    sumneko-lua-language-server
    ripgrep
  ];
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    webcord
    gnome.gnome-keyring
    # (discord.override {
    #   withOpenASAR = false;
    #   withVencord = true;
    # })
  ];
}

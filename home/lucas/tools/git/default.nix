_: {
  programs.git = {
    enable = true;
    userName = "patrulhasirius";
    userEmail = "patruop@gmail.com";
    extraConfig = {
      init = {defaultBranch = "main";};
      core.editor = "nvim";
      pull.rebase = false;
    };
  };
}

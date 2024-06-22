{pkgs, ...}: {
  home.packages = with pkgs; [
    poetry
    python3
    python312Packages.numpy # these two are
    python312Packages.scipy # probably redundant to pandas
    python312Packages.jupyterlab
    python312Packages.pandas
    python312Packages.statsmodels
    python312Packages.scikitlearn
    python312Packages.polars
  ];
}

{
  config,
  pkgs,
  system,
  emacs-overlay,
  ...
}:

let
  emacs = (pkgs.emacsPackagesFor emacs-overlay.packages.${system}.emacs-unstable-pgtk).withPackages (epkgs: [
    epkgs.mu4e
  ]);
in
{
  home.packages = [
    emacs
    pkgs.texinfo
    pkgs.cmake
    pkgs.libtool
    pkgs.ispell
  ];
}

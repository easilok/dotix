{
  config,
  pkgs,
  ...
}:

let
  # Emacs comes from nix-community/emacs-overlay (merged in flake overlays.default)
  emacs = (pkgs.emacsPackagesFor pkgs.emacs-unstable-pgtk).withPackages (epkgs: [
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

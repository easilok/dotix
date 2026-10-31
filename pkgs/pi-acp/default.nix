{ pkgs, ... }:

pkgs.buildNpmPackage {
  pname = "pi-acp";
  version = "0.0.34";

  src = pkgs.fetchFromGitHub {
    owner = "svkozak";
    repo = "pi-acp";
    rev = "v0.0.34";
    hash = "sha256-QRwxOtTZOY+Np3PkAoy2o2PrUzEqjItM/372sCPlSMo=";
  };

  npmDepsHash = "sha256-BvLNtFfp1cMVjzWcMRSdhTqiJrTfbFoUbWkkPW9200o=";

  nativeBuildInputs = [ pkgs.nodejs_22 ];
}

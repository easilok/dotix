{ pkgs, ... }: {
  services.podman = { enable = true; };

  home.packages = with pkgs; [
    dive
    podman-tui
    # docker-compose
    podman-compose
  ];
}

.PHONY: all home update rebuild home-clean clean gc

all: rebuild

update:
	nix flake update

rebuild:
	sudo nixos-rebuild switch --flake .#

home:
	home-manager switch --flake .#$(shell hostname)

home-clean:
	nix-collect-garbage --delete-older-than 30d

clean:
	sudo nix-collect-garbage --delete-older-than 30d

gc: clean home-clean

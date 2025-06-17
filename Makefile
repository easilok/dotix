.PHONY: all home update rebuild clean

all: rebuild

update:
	nix flake update

rebuild:
	sudo nixos-rebuild switch --flake .#

home:
	home-manager switch --flake .#$(shell hostname)

clean:
	sudo nix-collect-garbage --delete-older-than 7d

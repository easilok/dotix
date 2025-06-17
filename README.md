# Personal Nix configuration

## Setup

To use this configuration in a foreign distro, enable the *flakes* experimental features with the following content in `~/.config/nix/nix.conf`:

```nix
experimental-features = nix-command flakes
```

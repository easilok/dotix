# graphifyy Nix Package

## What is graphifyy?

[graphifyy](https://pypi.org/project/graphifyy/) is a Python package (v0.9.24) that provides the `graphify` CLI — a codebase graphing and analysis tool. It parses source code using tree-sitter grammars, builds a dependency graph, and supports exporting, querying, and MCP integration.

It is **not in nixpkgs**, so it's defined locally in this flake.

## How `default.nix` works

### Structure

```
pkgs/graphifyy/default.nix
├── mkGrammar helper    — builds a tree-sitter grammar from GitHub source
├── 19 grammar packages — tree-sitter grammars missing from nixpkgs
└── graphifyy derivation — the main package from PyPI
```

### `mkGrammar` helper

A thin wrapper around `python3Packages.buildPythonPackage` that takes GitHub
coordinates (`owner`, `repo`, `tag`) and builds a tree-sitter grammar package.
Uses `fetchFromGitHub` because PyPI sdists omit the `tree_sitter/parser.h` C
header needed at compile time (nixpkgs uses the same approach).

### Why `fetchFromGitHub` instead of `fetchPypi` / `fetchurl`

PyPI source distributions for tree-sitter grammars **do not include**
`tree_sitter/parser.h` or the generated `src/parser.c` files. These are
required to build the Python C extension. GitHub releases/tags include them.

### tree-sitter-swift special case

The `0.7.3` tag of `tree-sitter-swift` lacks `src/parser.c`. We use the
`0.7.3-with-generated-files` tag instead, which has version `0.0.1` in its
`pyproject.toml`. A `preConfigure` step patches the version to `0.7.3` so
the runtime dependency check passes.

### Missing grammars (19 total)

| Grammar | GitHub |
|---|---|
| tree-sitter-apex | `stadelmanma/tree-sitter-apex` |
| tree-sitter-blade | `airbus-cert/tree-sitter-blade` |
| tree-sitter-dm | `alex-pinkus/tree-sitter-dm` |
| tree-sitter-elixir | `elixir-lang/tree-sitter-elixir` |
| tree-sitter-fortran | `stadelmanma/tree-sitter-fortran` |
| tree-sitter-julia | `tree-sitter/tree-sitter-julia` |
| tree-sitter-objc | `alex-pinkus/tree-sitter-objc` |
| tree-sitter-pascal | `dannyvankooten/tree-sitter-pascal` |
| tree-sitter-razor | `amaanq/tree-sitter-razor` |
| tree-sitter-sln | `stadelmanma/tree-sitter-sln` |
| tree-sitter-sql | `derekstride/tree-sitter-sql` |
| tree-sitter-swift | `alex-pinkus/tree-sitter-swift` |
| tree-sitter-terraform | `danielsuo/tree-sitter-terraform` |
| tree-sitter-verilog | `tree-sitter/tree-sitter-verilog` |
| tree-sitter-zig | `maxxnino/tree-sitter-zig` |
| tree-sitter-c-sharp | `tree-sitter/tree-sitter-c-sharp` |
| tree-sitter-cmake | `uyha/tree-sitter-cmake` |
| tree-sitter-powershell | `airbus-cert/tree-sitter-powershell` |
| tree-sitter-dart | `UserNobody14/tree-sitter-dart` |

### Main `graphifyy` derivation

Uses `fetchurl` (PyPI sdist) since graphifyy is pure Python with no C
compilation. Includes the `mcp` extra which adds `mcp` and `starlette`
dependencies (both available in nixpkgs).

## Flake wiring

### `flake.nix`

- `overlays.default` exposes `pkgs.graphifyy`
- Overlay is applied to standalone home-manager `pkgs` import
- Overlay is added to all NixOS config module lists

### `home/ai.nix`

- `pkgs.graphifyy` added to `home.packages`
- User imports this into specific host configs

## Extracting into a standalone flake

To use this package in another project:

1. Copy `pkgs/graphifyy/default.nix` into your repo
2. Create a `flake.nix` that exposes it:

```nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      graphifyy = pkgs.callPackage ./default.nix { };
    in {
      packages.${system}.default = graphifyy;
    };
}
```

3. Build: `nix build .#`
4. Run: `./result/bin/graphify --help`

Or consume as a flake input:

```nix
{
  inputs.graphifyy.url = "github:your-org/your-repo";

  outputs = { self, nixpkgs, graphifyy }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ graphifyy.overlays.default ];
      };
    in {
      # pkgs.graphifyy is now available
    };
}
```

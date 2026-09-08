{
  lib,
  python3Packages,
  fetchFromGitHub,
  fetchurl,
}:

let
  # Helper for tree-sitter grammar packages that are missing from nixpkgs.
  # Uses fetchFromGitHub because the PyPI sdists don't include the
  # tree_sitter/parser.h C header needed at compile time.
  mkGrammar = { pname, version, owner, repo, tag, hash }:
    python3Packages.buildPythonPackage {
      inherit pname version;
      src = fetchFromGitHub {
        inherit owner repo;
        rev = tag;
        sha256 = "sha256:${hash}";
      };
      pyproject = true;

      build-system = [
        python3Packages.setuptools
      ];

      propagatedBuildInputs = [
        python3Packages.tree-sitter
      ];

      doCheck = false;
      pythonImportsCheck = [ (lib.replaceStrings [ "-"] [ "_"] pname) ];

      meta = {
        description = "${lib.concatStringsSep " " (lib.splitString "-" pname)} grammar for tree-sitter";
        homepage = "https://github.com/${owner}/${repo}";
        license = lib.licenses.mit;
      };
    };

  # Missing tree-sitter grammars (required by graphifyy, not in nixpkgs).
  # Each uses fetchFromGitHub because the grammar repos include the
  # tree_sitter/parser.h C header needed for compilation.
  tree-sitter-go = mkGrammar {
    pname = "tree-sitter-go";
    version = "0.23.4";
    owner = "tree-sitter";
    repo = "tree-sitter-go";
    tag = "v0.23.4";
    hash = "0yi8if9mqzzcs4qflflz90hhaxkzlq54wia3s0iiqzfqxk24a61g";
  };

  tree-sitter-typescript = mkGrammar {
    pname = "tree-sitter-typescript";
    version = "0.23.2";
    owner = "tree-sitter";
    repo = "tree-sitter-typescript";
    tag = "v0.23.2";
    hash = "0rlhhqp9dv6y0iljb4bf90d89f07zkfnsrxjb6rvw985ibwpjkh9";
  };

  tree-sitter-java = mkGrammar {
    pname = "tree-sitter-java";
    version = "0.23.5";
    owner = "tree-sitter";
    repo = "tree-sitter-java";
    tag = "v0.23.5";
    hash = "11j4ifhl5hsmb2sa651cp5xds9cjgjynl86yivvk6bnr2ba0xw9s";
  };

  tree-sitter-groovy = mkGrammar {
    pname = "tree-sitter-groovy";
    version = "0.1.2";
    owner = "amaanq";
    repo = "tree-sitter-groovy";
    tag = "v0.1.2";
    hash = "06cl88v9l8ip8r7vg5vcdbxygc7328kqqy7bq4skirdasgfi7j5s";
  };

  tree-sitter-c = mkGrammar {
    pname = "tree-sitter-c";
    version = "0.24.2";
    owner = "tree-sitter";
    repo = "tree-sitter-c";
    tag = "v0.24.2";
    hash = "0rg2836lrb4zc3rah67dhl18j8ngaamxrd537y0b68whn7krzsr6";
  };

  tree-sitter-cpp = mkGrammar {
    pname = "tree-sitter-cpp";
    version = "0.23.4";
    owner = "tree-sitter";
    repo = "tree-sitter-cpp";
    tag = "v0.23.4";
    hash = "0sbvvfa718qrjmfr53p8x3q2c19i4vhw0n20106c8mrvpsxm7zml";
  };

  tree-sitter-ruby = mkGrammar {
    pname = "tree-sitter-ruby";
    version = "0.23.1";
    owner = "tree-sitter";
    repo = "tree-sitter-ruby";
    tag = "v0.23.1";
    hash = "0c1vs63ydcb3q2wnif18l5irbj6chkcvd3p6dg0vyhklk5acrvca";
  };

  tree-sitter-kotlin = mkGrammar {
    pname = "tree-sitter-kotlin";
    version = "1.1.0";
    owner = "tree-sitter-grammars";
    repo = "tree-sitter-kotlin";
    tag = "v1.1.0";
    hash = "1bn5nk45j82p5smq9qv8sr2j4cbz0sy57s1nc1n4g51zn3kclf7a";
  };

  tree-sitter-scala = mkGrammar {
    pname = "tree-sitter-scala";
    version = "0.26.0";
    owner = "tree-sitter";
    repo = "tree-sitter-scala";
    tag = "v0.26.0";
    hash = "1g4ia61ibs66qchmwnddg9x02k4ix08jvma238msv9wqb90dqx0a";
  };

  tree-sitter-php = mkGrammar {
    pname = "tree-sitter-php";
    version = "0.23.11";
    owner = "tree-sitter";
    repo = "tree-sitter-php";
    tag = "v0.23.11";
    hash = "0qkjp5n3ys0jckg67zcdf4mkb01ilnkqx61wga13ys2infgd8agq";
  };

  tree-sitter-swift =
    let
      swift-src = fetchFromGitHub {
        owner = "alex-pinkus";
        repo = "tree-sitter-swift";
        rev = "0.7.3-with-generated-files";
        sha256 = "sha256:1zyl5jrvqasb1rqpf2p2hbmm4sqwn0i6jayvjn6rcil89smb0xaa";
      };
    in
    python3Packages.buildPythonPackage {
      pname = "tree-sitter-swift";
      version = "0.7.3";
      src = swift-src;
      pyproject = true;

      build-system = [
        python3Packages.setuptools
      ];

      propagatedBuildInputs = [
        python3Packages.tree-sitter
      ];

      # The with-generated-files tag has version 0.0.1 in pyproject.toml;
      # patch it to match the expected version.
      preConfigure = ''
        substituteInPlace pyproject.toml \
          --replace 'version = "0.0.1"' 'version = "0.7.3"'
      '';

      doCheck = false;
      pythonImportsCheck = [ "tree_sitter_swift" ];

      meta = {
        description = "Swift grammar for tree-sitter";
        homepage = "https://github.com/alex-pinkus/tree-sitter-swift";
        license = lib.licenses.mit;
      };
    };

  tree-sitter-lua = mkGrammar {
    pname = "tree-sitter-lua";
    version = "0.5.0";
    owner = "tree-sitter-grammars";
    repo = "tree-sitter-lua";
    tag = "v0.5.0";
    hash = "1mhlwpj4ajqajgjw99l9xhiqnyg9hwn7zdgvdw037vk3k8vrldjp";
  };

  tree-sitter-zig = mkGrammar {
    pname = "tree-sitter-zig";
    version = "1.1.2";
    owner = "tree-sitter-grammars";
    repo = "tree-sitter-zig";
    tag = "v1.1.2";
    hash = "1r9p7hhnc1zagwxzdxhs4p6rnqs9naddkgbfymi6pbw6cyg2ccwl";
  };

  tree-sitter-powershell = mkGrammar {
    pname = "tree-sitter-powershell";
    version = "0.26.4";
    owner = "airbus-cert";
    repo = "tree-sitter-powershell";
    tag = "v0.26.4";
    hash = "059hjmvrg15d3danpdz8ilkbwlxr59vpk6j9y03gy4jnk6vqfqyy";
  };

  tree-sitter-elixir = mkGrammar {
    pname = "tree-sitter-elixir";
    version = "0.3.5";
    owner = "elixir-lang";
    repo = "tree-sitter-elixir";
    tag = "v0.3.5";
    hash = "095k4zmpgnmszm8ljxpy93q0gyxks4c6b2vawiw5hw39iyvzx7qb";
  };

  tree-sitter-objc = mkGrammar {
    pname = "tree-sitter-objc";
    version = "3.0.2";
    owner = "tree-sitter-grammars";
    repo = "tree-sitter-objc";
    tag = "v3.0.2";
    hash = "1fryxjjxjq7lz93vvcm3lswshb4drywf64knbvjxrr3lq5zh5bv8";
  };

  tree-sitter-julia = mkGrammar {
    pname = "tree-sitter-julia";
    version = "0.23.1";
    owner = "tree-sitter";
    repo = "tree-sitter-julia";
    tag = "v0.23.1";
    hash = "0xi04a48ly438gar25bkkvvr8by4dd013cnafbjdysqjfs04q2wg";
  };

  tree-sitter-verilog = mkGrammar {
    pname = "tree-sitter-verilog";
    version = "1.0.3";
    owner = "tree-sitter";
    repo = "tree-sitter-verilog";
    tag = "v1.0.3";
    hash = "1mk8waij5lbj1wbayvqs0cxk003dssdic13h14gd5fi1ckfvflja";
  };

  tree-sitter-fortran = mkGrammar {
    pname = "tree-sitter-fortran";
    version = "0.6.0";
    owner = "stadelmanma";
    repo = "tree-sitter-fortran";
    tag = "v0.6.0";
    hash = "10i2sqx1y8khvqkr5idg8rkwpzfiq997ikiaf13318yabyam3vwd";
  };

in

python3Packages.buildPythonApplication {
  pname = "graphifyy";
  version = "0.9.24";
  pyproject = true;

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/17/f0/e04204dd4c69301a0ff93bc8f4c8eca7665a2f8318fb128a3352894a436d/graphifyy-0.9.24.tar.gz";
    hash = "sha256-YuXc2QfUJlLaLcDyEjrhzAyjaDEP7f971ujcqM5uXDE=";
  };

  build-system = [
    python3Packages.setuptools
  ];

  propagatedBuildInputs = [
    # Core dependencies (from nixpkgs)
    python3Packages.networkx
    python3Packages.numpy
    python3Packages.rapidfuzz
    python3Packages.tree-sitter
    python3Packages."tree-sitter-python"
    python3Packages."tree-sitter-javascript"
    python3Packages."tree-sitter-c-sharp"
    python3Packages."tree-sitter-rust"
    python3Packages."tree-sitter-bash"
    python3Packages."tree-sitter-json"
    # Missing tree-sitter grammars (defined above)
    tree-sitter-go
    tree-sitter-typescript
    tree-sitter-java
    tree-sitter-groovy
    tree-sitter-c
    tree-sitter-cpp
    tree-sitter-ruby
    tree-sitter-kotlin
    tree-sitter-scala
    tree-sitter-php
    tree-sitter-swift
    tree-sitter-lua
    tree-sitter-zig
    tree-sitter-powershell
    tree-sitter-elixir
    tree-sitter-objc
    tree-sitter-julia
    tree-sitter-verilog
    tree-sitter-fortran
    # MCP extra
    python3Packages.mcp
    python3Packages.starlette
  ];

  doCheck = false;

  meta = {
    description = "AI coding assistant skill - turn any folder of code, docs, papers, images, or videos into a queryable knowledge graph";
    homepage = "https://github.com/Graphify-Labs/graphify";
    license = lib.licenses.mit;
    mainProgram = "graphify";
  };
}

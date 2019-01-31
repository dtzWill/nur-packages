{ nixpkgs ? (fetchTarball channel:nixos-unstable),
  src ? (fetchGit ../.)
}:

# Evaluate 'release.nix' but don't abort on unfree, just log and skip

let
  logHandler = msg: builtins.trace "Ignoring evaluation failure of unfree:\n${msg}" true;
  toplevel = import (src + "/release.nix") {
    inherit nixpkgs;
    args.config = {
      allowUnfree = false;
      handleEvalIssue = reason:
        if reason == "unfree" then logHandler else throw;
    };
  };
in
  toplevel // {
    pkgs = builtins.removeAttrs toplevel.pkgs [
      "stoke" "stoke-haswell" "stoke-sandybridge"
    ];
  }

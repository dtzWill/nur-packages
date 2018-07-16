{ stdenv, git, fetchgit, ocamlPackages, makeWrapper, z3 }:

let
  solverPath = stdenv.lib.makeBinPath [ z3 ];
in
ocamlPackages.buildOcaml rec {
  name = "kittel-koat";
  version = "2017-01-15";

  src = fetchgit {
    url = "http://github.com/s-falke/kittel-koat.git";
    rev = "b8618f7f7a3cb40dd0f7bb1d60696afc32cf9986";
    sha256 = "04rpcz6l0wllzwb0vg17c3800rkq9ykc49zm7qgy7fdn4nr6pwyy";
    leaveDotGit = true;
  };

  buildInputs = with ocamlPackages; [ git ocamlgraph makeWrapper ];

  patchPhase = ''
    patchShebangs make_git_sha1.sh
  '';

  configurePhase = ''
    cat > user.cfg <<EOF
    HAVE_APRON=false
    HAVE_Z3=false
    EOF

    substituteInPlace Makefile --replace ocamlbuild "ocamlbuild -pkg ocamlgraph"
  '';

  installPhase = ''
    install -Dm755 {_build,$out/libexec}/kittel.native
    install -Dm755 {_build,$out/libexec}/koat.native

    mkdir -p $out/bin
    makeWrapper "$out/libexec/kittel.native -smt-solver z3" $out/bin/kittel --prefix PATH : ${solverPath}
    makeWrapper "$out/libexec/koat.native -smt-solver z3" $out/bin/koat --prefix PATH : ${solverPath}
  '';
}

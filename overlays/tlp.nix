self: super: {
  tlp = super.tlp.overrideAttrs (o: rec {
    name = "tlp-${version}";
    version = "2018-12-21";
    src = super.fetchFromGitHub {
      owner = "linrunner";
      repo = "tlp";
      rev = "264a98b29edb2da10bcb622d7ecbeff65e21bdc2";
      sha256 = "0nj2xnd7c4fqpibqv9fpwxkrlv5rk3aw9a2rhsvj80vpkc89qz49";
    };

    makeFlags = (o.makeFlags or []) ++ [
      # not sure why we put things in share/tlp-pm vs default share/tlp
      # but follow along for now.
      "TLP_FLIB=${placeholder "out"}/share/tlp-pm/func.d"
    ];

    # Fix typo
    postPatch = (o.postPatch or "") + ''
      substituteInPlace tlp-stat.in --replace echofi echo
    '';
  });
}

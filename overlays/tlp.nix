self: super: {
  tlp = super.tlp.overrideAttrs (o: rec {
    name = "tlp-${version}";
    version = "2018-12-17";
    src = super.fetchFromGitHub {
      owner = "linrunner";
      repo = "tlp";
      rev = "570cd7a9100585621cece30d03149617997c4c7e";
      sha256 = "09nsfmayxng0mc9jg1nf8k05aq3v93xwch4kjf60qrpxm4pdg6gs";
    };

    makeFlags = (o.makeFlags or []) ++ [
      "TLP_FLIB=${placeholder "out"}/share/tlp/func.d"
    ];
  });
}

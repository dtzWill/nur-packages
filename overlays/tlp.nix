self: super: {
  tlp = super.tlp.overrideAttrs (o: rec {
    name = "tlp-${version}";
    version = "2019-02-25";
    src = super.fetchFromGitHub {
      owner = "linrunner";
      repo = "tlp";
      rev = "bcb384a4513fe5c6c3cb3604429dc4ccbac62842";
      sha256 = "1hlhvfv6b87n7mm6ppf1rkzx4v5apjlxkzkxb28lswlrc7qc1d8g";
    };

    makeFlags = (o.makeFlags or []) ++ [
      # not sure why we put things in share/tlp-pm vs default share/tlp
      # but follow along for now.
      "TLP_FLIB=${placeholder "out"}/share/tlp-pm/func.d"
    ];
  });
}

self: super: {
  tlp = super.tlp.overrideAttrs (o: rec {
    name = "tlp-${version}";
    version = "2019-04-10";
    #version = "1.2.1";
    src = super.fetchFromGitHub {
      owner = "linrunner";
      repo = "tlp";
      #rev = "527b0e1acbf77dad13e973bd2a98412acadd5e7f";
      rev = "5d2abde9ee05014e17007bbf870a878ff11e890b";
      #rev = version;
      sha256 = "01vs7z4ngqaqr725ii4ddz0rc9km24s6zcry6lhv0jyvpyqvzpd7";
    };

    makeFlags = (o.makeFlags or []) ++ [
      # not sure why we put things in share/tlp-pm vs default share/tlp
      # but follow along for now.
      "TLP_FLIB=${placeholder "out"}/share/tlp-pm/func.d"
    ];
  });
}

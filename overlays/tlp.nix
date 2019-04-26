self: super: {
  tlp = super.tlp.overrideAttrs (o: rec {
    name = "tlp-${version}";
    version = "2019-04-26";
    #version = "1.2.1";
    src = super.fetchFromGitHub {
      owner = "linrunner";
      repo = "tlp";
      #rev = "527b0e1acbf77dad13e973bd2a98412acadd5e7f";
      rev = "1aa881bd9623add325987d5b7309518b10b36708";
      #rev = version;
      sha256 = "0lp35p1221fb1rxjg12a5jh24vd8kdxw96al6kqsngbywwvszx6n";
    };
  });
}

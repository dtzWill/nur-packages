self: super: {
  tlp = super.tlp.overrideAttrs (o: rec {
    name = "tlp-${version}";
    version = "2019-04-28";
    #version = "1.2.1";
    src = super.fetchFromGitHub {
      owner = "linrunner";
      repo = "tlp";
      #rev = "527b0e1acbf77dad13e973bd2a98412acadd5e7f";
      rev = "ce7e2431b37db3864d9cf08d0658aeeb17f902a6";
      #rev = version;
      sha256 = "0izf7l5w1zwn94fmr726mbpf0qh1cpmsqrp61ky2b5hg4gdm1g7x";
    };
  });
}

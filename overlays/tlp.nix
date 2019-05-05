self: super: {
  tlp = super.tlp.overrideAttrs (o: rec {
    name = "tlp-${version}";
    #version = "2019-04-28";
    version = "1.2.2";
    src = super.fetchFromGitHub {
      owner = "linrunner";
      repo = "tlp";
      #rev = "527b0e1acbf77dad13e973bd2a98412acadd5e7f";
      #rev = "ce7e2431b37db3864d9cf08d0658aeeb17f902a6";
      rev = version;
      sha256 = "0vm31ca6kdak9xzwskz7a8hvdp67drfh2zcdwlz3260r8r2ypgg1";
    };
  });
}

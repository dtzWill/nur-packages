self: super: {
  awesome = super.awesome.overrideAttrs (o: rec {
    name = "awesome-4.2-git-${version}";
    version = "2019-01-27";
    nativeBuildInputs = o.nativeBuildInputs or [] ++ [ self.asciidoctor ];
    src = super.fetchFromGitHub {
      owner = "AwesomeWM";
      repo = "awesome";
      rev = "febbbb69a505bf20e26563467f04f5c75176c1b9";
      sha256 = "0ixq14lpwrg6djskk7kjqlawg1bvqq68b8vdqlv5khzvjdl4wdc3";
    };
  });
}

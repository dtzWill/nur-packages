self: super: {
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    version = "4.3";
    name = "${pname}-${version}"; # override
    #name = "awesome-4.2-git-${version}";
    #version = "2019-01-27";
    nativeBuildInputs = o.nativeBuildInputs or [] ++ [ self.asciidoctor ];
    src = super.fetchFromGitHub {
      owner = "AwesomeWM";
      repo = "awesome";
      #rev = "febbbb69a505bf20e26563467f04f5c75176c1b9";
      rev = "v${version}";
      sha256 = "1i7ajmgbsax4lzpgnmkyv35x8vxqi0j84a14k6zys4blx94m9yjf";
    };
  });
}

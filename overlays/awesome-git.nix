self: super: {
  # XXX: This assumes base 'awesome' is 4.3(+?), which it is on master
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-03-20";
    src = super.fetchFromGitHub {
      owner = "dtzWill"; # "AwesomeWM";
      repo = "awesome";
      rev = "eecdeb7d469b061a2499eff3a60c6847d5cee020";
      sha256 = "16pkxd33ihcczjs6nbwj4jwd873l6pd0129av9nhf773zdhnqq8z";
    };
    buildInputs = (o.buildInputs or []) ++ [ self.xorg.xcbutilerrors ];

    #doCheck = true;
  });
}

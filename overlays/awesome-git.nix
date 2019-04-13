self: super: {
  # XXX: This assumes base 'awesome' is 4.3(+?), which it is on master
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-04-13"; # with new notification support, WIP
    src = super.fetchFromGitHub {
      owner = "AwesomeWM"; # "dtzWill";
      repo = "awesome";
      rev = "dc1f87ef840c1297d0fdc80343261d23a89254cc";
      sha256 = "0cm7ir0midxka01k2pl9b6k5lkx1jwqq88k1a5hbkgym5anxzn1j";
    };
    buildInputs = (o.buildInputs or []) ++ [ self.xorg.xcbutilerrors ];

    #doCheck = true;
  });
}

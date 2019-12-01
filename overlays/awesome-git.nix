self: super: {
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-11-30";
    src = super.fetchFromGitHub {
      owner = "AwesomeWM";
      repo = "awesome";
      rev = "4cac2463ad28c1c6f3ca38e5e7d07f2750976f6c";
      sha256 = "1r4rgyqpqksx69irnm3pzx477b32pa6685qfwalcx48vlkygvdy9";
    };
    buildInputs = (o.buildInputs or []) ++ [ self.xorg.xcbutilerrors ];

    #doCheck = true;
  });
}

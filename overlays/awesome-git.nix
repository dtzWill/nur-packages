self: super: {
  # XXX: This assumes base 'awesome' is 4.3(+?), which it is on master
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-03-22";
    src = super.fetchFromGitHub {
      owner = "dtzWill"; # "AwesomeWM";
      repo = "awesome";
      rev = "f814ef0a94428bcddbbe2c69c1d89c5a37812bed";
      sha256 = "1n0vxp0bfl1c5nj2nn5ab6sbq20znwqnlgnx2nrp9yz1jd6fnyvb";
    };
    buildInputs = (o.buildInputs or []) ++ [ self.xorg.xcbutilerrors ];

    #doCheck = true;
  });
}

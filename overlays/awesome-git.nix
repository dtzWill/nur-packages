self: super: {
  # XXX: This assumes base 'awesome' is 4.3(+?), which it is on master
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-03-16";
    src = super.fetchFromGitHub {
      owner = "dtzWill"; # "AwesomeWM";
      repo = "awesome";
      rev = "f4b844589a7dc717c28271e533c865eed5d73b6e";
      sha256 = "0b3mwdi7s5xs59089bis3rafgs335sb4g0i1q7h57c9skrngpnhk";
    };
    buildInputs = (o.buildInputs or []) ++ [ self.xorg.xcbutilerrors ];

    #doCheck = true;
  });
}

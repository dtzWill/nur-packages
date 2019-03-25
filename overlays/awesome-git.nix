self: super: {
  # XXX: This assumes base 'awesome' is 4.3(+?), which it is on master
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-03-25"; # with new notification support, WIP
    src = super.fetchFromGitHub {
      owner = "dtzWill"; # "AwesomeWM";
      repo = "awesome";
      rev = "f2ed14dd2211d88406250d2ef250ed1cc3550e6b";
      sha256 = "11flw2v67kjrbfhc0mixqkv9x9nip8z12hx6a2jkwcywvgz5i1r1";
    };
    buildInputs = (o.buildInputs or []) ++ [ self.xorg.xcbutilerrors ];

    #doCheck = true;
  });
}

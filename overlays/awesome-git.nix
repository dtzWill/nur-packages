self: super: {
  # XXX: This assumes base 'awesome' is 4.3(+?), which it is on master
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-04-15"; # with new notification support, WIP
    src = super.fetchFromGitHub {
      owner = "AwesomeWM"; # "dtzWill";
      repo = "awesome";
      rev = "df0cdbed615512931f72ba2cbff09b2a3453a955";
      sha256 = "0bqlgqfz6pzzk21qgd1hxyrb51pwxy5393yx4bkw53qyy7y415rs";
    };
    buildInputs = (o.buildInputs or []) ++ [ self.xorg.xcbutilerrors ];

    #doCheck = true;
  });
}

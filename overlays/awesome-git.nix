self: super: {
  # XXX: This assumes base 'awesome' is 4.3(+?), which it is on master
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-04-02"; # with new notification support, WIP
    src = super.fetchFromGitHub {
      owner = "dtzWill"; # "AwesomeWM";
      repo = "awesome";
      rev = "3ec13091933c04f7bdda8f88996f7339456ea5e6";
      sha256 = "1dcy51gr02sm2w8a1q0kl1hi51b3vzlhqam2ngrz794dnhkhaz9x";
    };
    buildInputs = (o.buildInputs or []) ++ [ self.xorg.xcbutilerrors ];

    #doCheck = true;
  });
}

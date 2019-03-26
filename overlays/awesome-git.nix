self: super: {
  # XXX: This assumes base 'awesome' is 4.3(+?), which it is on master
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-03-25"; # with new notification support, WIP
    src = super.fetchFromGitHub {
      owner = "dtzWill"; # "AwesomeWM";
      repo = "awesome";
      rev = "04daf4596b5fe26c01010d0ed95361b13143506a";
      sha256 = "1x7mbgd653ygg7axxw7p9qjivf7qq23zi4bd9is4ycbyr3zzxdr8";
    };
    buildInputs = (o.buildInputs or []) ++ [ self.xorg.xcbutilerrors ];

    #doCheck = true;
  });
}

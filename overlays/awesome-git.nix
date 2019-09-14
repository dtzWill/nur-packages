self: super: {
  # XXX: This assumes base 'awesome' is 4.3(+?), which it is on master
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-09-14";
    src = super.fetchFromGitHub {
      owner = "AwesomeWM"; # "dtzWill";
      repo = "awesome";
      rev = "caf9a26660a721262e6fe34a1c746719d8806d4f";
      sha256 = "1a02b9avdsfsacscgnm45jx5qpvkp7zp62qc5rq5473a27y7fy4p";
    };
    buildInputs = (o.buildInputs or []) ++ [ self.xorg.xcbutilerrors ];

    postPatch = (o.postPatch or "") + ''
      patchShebangs tests/run.sh
      patchShebangs tests/themes/run.sh
      patchShebangs utils/awesome-client
      sed -i '/dbus-launch/d' tests/run.sh
    '';
    checkInputs = (o.checkinputs or []) ++ [
      self.xorg.xorgserver /* Xephyr or Xvfb */
      self.dbus
      self.xorg.xrdb
      self.ncurses /* tput */
      self.which
    ];
    preCheck = (o.preCheck or "") + ''
      export HEADLESS=1
      export TEST_PAUSE_ON_ERRORS=0
      dbus-run-session --config-file=${self.dbus.daemon}/share/dbus-1/session.conf \
      make check-integration
    '';
    doCheck = true;
  });
}

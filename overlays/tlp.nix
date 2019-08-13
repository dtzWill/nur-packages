self: super: {
  tlp = super.tlp.overrideAttrs (o: rec {
    name = "tlp-${version}";
    #version = "2019-04-28";
    version = "2019-08-13";
    src = super.fetchFromGitHub {
      owner = "linrunner";
      repo = "tlp";
      rev = "1a28bc629b43d83760c6b20411c2be3135e64177";
      #rev = version;
      sha256 = "1h34yfjgzmwksxvr6634k32aa0argxmijfwc4wn3yx8cchplc1rn";
    };
  });
}

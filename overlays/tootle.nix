self: super: {
  tootle = super.tootle.overrideAttrs (o: rec {
    name = "tootle-${version}";
    version = "2018-08-27";
    src = super.fetchFromGitHub {
      owner = "bleakgrey";
      repo = "tootle";
      rev = "7b3dbfe7e6aba5f39366ae8e310c965dfd6aa148";
      sha256 = "0wa04cljv6nhg6j9ygs7hhariwgnxjdmgfpvhb5w4677jq3zspjc";
    };
  });
}

self: super: {
  # XXX: This assumes base 'awesome' is 4.3(+?), which it is on master
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-02-23";
    src = super.fetchFromGitHub {
      owner = "AwesomeWM";
      repo = "awesome";
      rev = "36d7535cd55990d1ffe8182a3e52f953e23b862a";
      sha256 = "0gb0jyf9hbid936yk35hn6mmqrk337sgkdzlnx03yjdqb2wq7n9l";
    };
  });
}

self: super: {
  taskwarrior = super.taskwarrior.overrideAttrs (o: rec {
    name = "taskwarrior-${version}";
    version = "2018-08-12"; # latest on 2.6.0 branch
    src = super.fetchFromGitHub {
      owner = "GothenburgBitFactory";
      repo = "taskwarrior";
      rev = "bd221a5adc43e5c70e05eb4f7a48d1db3d18555d";
      sha256 = "1vz6fgibmyipmwazrash3clhjarjwqv1r55sjb4miczw06mcbddp";
    };
    patches = [];
  });
}

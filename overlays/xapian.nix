self: super: {
  xapian = super.xapian.overrideAttrs(o: rec {
    name = "xapian-${version}";
    version = "2018-10-09";
    src = super.fetchFromGitHub {
      owner = "xapian";
      repo = "xapian";
      rev = "4ca08213fcf5eca4d844cb522cad18235c81875c";
      sha256 = "0g40bdci54049myjvdb7dr95hbj8rk4hjg406lsibydi067w19gz";
    };
    patches = null; # Drop patch from upstream included by using latest
  });
}

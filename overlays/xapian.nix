self: super: {
  xapian = super.xapian.overrideAttrs(o: rec {
    name = "xapian-${version}";
    version = "2018-10-09";
    src = super.fetchgit {
      url = "https://github.com/xapian/xapian";
      rev = "4ca08213fcf5eca4d844cb522cad18235c81875c";
      sha256 = "168whd1lf4jm5w601ak805g3jzj54n44sh1cyfs1lba8vm9wfpbx";
      leaveDotGit = true;
    };
    patches = null; # Drop patch from upstream included by using latest

    nativeBuildInputs = (o.nativeBuildInputs or []) ++ [ self.perl ];

    preAutoreconf = ''
      patchShebangs bootstrap */preautoreconf
      ./bootstrap
    '';
  });
}

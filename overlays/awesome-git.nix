self: super: {
  awesome = super.awesome.overrideAttrs (o: rec {
    name = "awesome-4.2-git-${version}";
    version = "2018-10-16";
    src = super.fetchFromGitHub {
      owner = "AwesomeWM";
      repo = "awesome";
      rev = "4744a744f014e974aa9f7c092bac82752bab547b";
      sha256 = "065ars725hqlv3a00a9vlanrjrcmnyvc7cfrwyg21xqdyb2hiapw";
    };
  });
}

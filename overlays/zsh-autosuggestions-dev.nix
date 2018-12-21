self: super: {
  zsh-autosuggestions-dev = super.zsh-autosuggestions.overrideAttrs (o: rec {
    name = "zsh-autosuggestions-${version}";
    version = "0.5.0";
    src = super.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-autosuggestions";
#      rev = "v${version}";
      rev = "ebc2c07ac87388f70047f38083f747f296cffb6a";
      sha256 = "0q3p4azra8afdd3nsk4rc342kf3hik2jb3zsag749l6zhwirvd33";
    };
  });
}

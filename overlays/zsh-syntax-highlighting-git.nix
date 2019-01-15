self: super: {
  zsh-syntax-highlighting = super.zsh-syntax-highlighting.overrideAttrs (o: rec {
    name = "zsh-syntax-highlighting-redrawhook-${version}";
    version = "2018-10-13";
    src = super.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-syntax-highlighting";
#      rev = "v${version}";
      rev = "8d4c6355e6d252f1d67beca4df946f8335fac51c";
      sha256 = "0chjr17f6czjdyl503ydmgbcsndv0wm34bsqrqb42cdqjxx6imdl";
    };
  });
}

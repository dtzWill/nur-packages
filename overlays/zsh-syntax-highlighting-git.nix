self: super: {
  zsh-syntax-highlighting = super.zsh-syntax-highlighting.overrideAttrs (o: rec {
    name = "zsh-syntax-highlighting${version}";
    version = "2019-01-13";
    src = super.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-syntax-highlighting";
#      rev = "v${version}";
      rev = "2f3b98ff6f94ed1b205e8c47d4dc54e6097eacf4";
      sha256 = "1lyas0ql3v5yx6lmy8qz13zks6787imdffqnrgrpfx8h69ylkv71";
    };
  });
}

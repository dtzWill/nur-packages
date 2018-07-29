{ fetchFromGitHub }:

{
  version = "2018-05-11";
  src = fetchFromGitHub {
    owner = "trailofbits";
    repo = "mcsema";
    rev = "67164c725e07c8d07a240dccb2b2c0ea598a5ea2";
    sha256 = "1x2sakarqs4jljjjgk10x4zjfncms0v54mhfzyy6r89wvp2a1pl9";
    name = "mcsema-source";
  };
}

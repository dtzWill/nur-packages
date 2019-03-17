{ fetchFromGitHub }:

{
  version = "2019-03-13";
  src = fetchFromGitHub {
    owner = "trailofbits";
    repo = "mcsema";
    rev = "a8176f141f570e4e423655a8416fe61d01137377";
    sha256 = "1lnali60ifddhwyjgdsxs4x61whscqgjqrrpicwlbf8vj10ynfkz";
    name = "mcsema-source";
  };
}

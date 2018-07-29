{ fetchFromGitHub }:

{
  version = "2018-07-09";
  src = fetchFromGitHub {
    owner = "trailofbits";
    repo = "mcsema";
    rev = "23800ebb8a931cd691738210187905917c027c23";
    sha256 = "0l8y342na2syr7fig6z62f6iwwvivxnbns1sv2a8x5mgws8sx044";
    name = "mcsema-source";
  };
}

{ fetchFromGitHub }:

{
  version = "2018-08-05";
  src = fetchFromGitHub {
    owner = "trailofbits";
    repo = "mcsema";
    rev = "7da9994c37496e99c773cbbfe2e2aa251e1b7b70";
    sha256 = "1x54msihl6p23nx1ngkkz6i562bys21cn676ndyy86fbb6jqsmvf";
    name = "mcsema-source";
  };
}

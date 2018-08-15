{ fetchFromGitHub }:

{
  version = "2018-08-14";
  src = fetchFromGitHub {
    owner = "trailofbits";
    repo = "mcsema";
    rev = "f42ec1ff939a48c16d1bb4014f8212868e94e35e";
    sha256 = "0qqp9b4waasw1s8q6dcpd00jcbw9kdml0m2nkg0g50cbwiqah6az";
    name = "mcsema-source";
  };
}

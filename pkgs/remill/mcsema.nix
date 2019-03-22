{ fetchFromGitHub }:

{
  version = "2019-03-18";
  src = fetchFromGitHub {
    owner = "trailofbits";
    repo = "mcsema";
    rev = "b8146a30e4c04fbc4771d6abae0a5aacbfb8df06";
    sha256 = "057p7fcyl728hjviw6qy13psmbg0hgll6myq2jks74r2c94mcr1h";
    name = "mcsema-source";
  };
}

{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "vmir-${version}";
  version = "2018-08-28";

  src = fetchFromGitHub {
    owner = "andoma";
    repo = "vmir";
    rev = "e81176b539a34d86e5f638b5ee10fb79c184109b";
    sha256 = "0hj2r6ryzxyrdxx15wmnzqxxvm113q7gf5ryi7pqyh17ilflvsxk";
  };

  installPhase = ''
    install -Dm755 {,$out/bin/}vmir
  '';

  meta = with stdenv.lib; {
    description = "Virtual Machine for Intermediate Representation";
    homepage = https://github.com/andoma/vmir;
    license = licenses.mit;
    maintainers = with maintainers; [ dtzWill ];
  };
}

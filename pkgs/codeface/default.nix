{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "codeface-${version}";
  version = "2018-04-30";

  src = fetchFromGitHub {
    owner = "chrissimpkins";
    repo = "codeface";
    rev = "ac9064e7b585ba190b201e5f386c47f3bbceb51b";
    sha256 = "1hc21k0y6mf7ls6js9wqyaxv0vkyrmfadl8szvpymj8bvs27gbv8";
  };

  # TODO: otf
  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp */*.ttf $out/share/fonts/truetype/
  '';

  meta = with stdenv.lib; {
    description = "codeface fonts";
    homepage = https://github.com/chrissimpkins/codeface;
    #license = licenses.mit;
    maintainers = with maintainers; [ dtzWill ];
    platforms = platforms.all;
  };
}

{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "source-code-pro-variable-fonts";
  version = "1.010";

  srcs = [
    (fetchurl { url = https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.otf;
    sha256 = "0bcrd5l5nrd1amhajknlvsaabqlwnwkjl1j4vrpq2232bwkdv3xg"; })
    (fetchurl { url = https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.otf;
    sha256 = "0lqkl517wv34lnhida4pf4iv21rdjwvnrim79bbilw703wy3mjmj"; })
  ];

  buildCommand = ''
    mkdir -p $out/share/fonts/opentype/
    cp -a $srcs $out/share/fonts/opentype/
  '';

  meta = {
    description = "A set of monospaced OpenType fonts designed for coding environments (variable)";
    maintainers = with stdenv.lib.maintainers; [ dtzWill ];
    platforms = with stdenv.lib.platforms; all;
    homepage = https://blog.typekit.com/2012/09/24/source-code-pro/;
    license = stdenv.lib.licenses.ofl;
  };
}

{ stdenv, fetchzip }:

let
  version = "2.0.0";
  mkSS = ss: sha256:
    let pname = "iosevka-term-ss${ss}"; in fetchzip rec {
    name = "${pname}-${version}";

    url = "https://github.com/be5invis/Iosevka/releases/download/v${version}/${name}.zip";

    postFetch = ''
      mkdir -p $out/share/fonts/
      unzip -j $downloadedFile ttf/\*.ttf -d $out/share/fonts/iosevka
    '';

    inherit sha256;

    meta = with stdenv.lib; {
      homepage = https://be5invis.github.io/Iosevka/;
      downloadPage = "https://github.com/be5invis/Iosevka/releases";
      description = pname;
      longDescription= ''
        Slender monospace sans-serif and slab-serif typeface inspired by Pragmata
        Pro, M+ and PF DIN Mono, designed to be the ideal font for programming.
      '';
      license = licenses.ofl;
      platforms = platforms.all;
    };
  };
in {
  ss01 = mkSS "01" "00qg16m3h97lvdy9gay04pfkyn8vdgg0sh681v20sd6jd045nc4y";
  ss02 = mkSS "02" "0rcfsbcvmb4wi90b4w74w534cchlsbrxvwbsrxhzz5l0bbcghbsg";
  ss03 = mkSS "03" "0m3xr7h877nh1n76rmngavdd5vars2qxnax6w88pl0gqjxzqcvn7";
  ss04 = mkSS "04" "1nm2x53njp1fsih2fapqb4h4aaw5g22y3g928ijrjhzgf1apmwdx";
  ss05 = mkSS "05" "0inj5qzr9q7mdvfwk2azy07vwazlwgnmyzggf347ap3z9fp7wng9";
  ss06 = mkSS "06" "0lva1m3adrfniyj4xxkiqxv18zny9447b8k1smf1cc1nddbiais4";
  ss07 = mkSS "07" "088ya124is2458pr3icyjf76cai8v9ixyq9i7kj2fmmdwmy75dj6";
  ss08 = mkSS "08" "192rdhl1a56h66xnv8k4gqd1v7sybl93iphgd0fvgfw4lyzcl4pj";
  ss09 = mkSS "09" "1ziwgjd6wxq4d7l6b3i8k43wbcxbfals29xhbizfj2lh0bjqfr8m";
  ss10 = mkSS "10" "1h4wqnbpxbihzddwyv046mrmiw2d1a54c6pxdvncp0iv4r4iq9g9";
  ss11 = mkSS "11" "08ccpqkx5vm2c9iv8fc7l2h0xiqap05jqc6wwpkg8klpxscsrr95";
}

{ stdenv, fetchFromGitHub
, meson, ninja, pkgconfig
, xorg
, glm
, python3
, boost
, vulkan-headers
, vulkan-loader
, shaderc
, makeWrapper
}:

let
  args_hxx = builtins.fetchurl {
    url = https://raw.githubusercontent.com/Taywee/args/6cd243def4b335efa5a83acb4d29aee482970d2e/args.hxx;
    sha256 = "0lbhqjlii0q1jdwb7pd9annhrlsfarkmdx7zbfllw5wxqrsmj8nc";
  };
  pyboost = python3.pkgs.toPythonModule boost;
  pypkgs =  with python3.pkgs; [ xlib psutil pyboost python ];
  xpkgs = with xorg; [ libxcb xcbutil xcbutilkeysyms xcbutilwm libX11 ];
in
stdenv.mkDerivation rec {
  pname = "chamferwm";
  version = "2019-03-18";
  src = fetchFromGitHub {
    owner = "jaelpark";
    repo = pname;
    rev = "6e5e0432f1122a0d58301e61f0f93092993cf62d";
    sha256 = "0kyqahfci2lqlhh6hi621zz2ydd5k59pwhq57m8phdl02051z1sf";
  };

  # to make use easier, use install locations as defaults for path args
  postPatch = ''
    substituteInPlace src/main.cpp \
      --replace $'{"config",\'c\'},"config.py");' \
                $'{"config",\'c\'},"${placeholder "out"}/share/chamfer/config/config.py");' \
      --replace '{"shader-path"});' \
                '{"shader-path"},{"${placeholder "out"}/share/chamfer/shaders"});'

    cp ${args_hxx} third/args/args.hxx
  '';

  nativeBuildInputs = [ meson ninja pkgconfig shaderc makeWrapper ];
  buildInputs = [ glm boost vulkan-headers vulkan-loader ] ++ pypkgs ++ xpkgs;

  # Default copies over the shaders, which is a start but.. ;)
  # Based on upstream's linked PKGBUILD:
  # https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=chamfer-git
  installPhase = ''
    install -Dm755 -t $out/bin chamfer
    install -Dm755 -t $out/share/chamfer/shaders *.spv
    install -Dm755 -t $out/share/chamfer/config ../config/*
  '';

  postFixup = ''
    wrapProgram $out/bin/chamfer --set PYTHONPATH "${python3.pkgs.makePythonPath pypkgs}"
  '';
}


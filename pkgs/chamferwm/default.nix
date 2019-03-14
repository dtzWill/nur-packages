{ stdenv, fetchFromGitHub
, meson, ninja, pkgconfig
, xorg
, glm
, python3
, boost
, vulkan-headers
, vulkan-loader
, shaderc
}:

let
  args_hxx = builtins.fetchurl {
    url = https://raw.githubusercontent.com/Taywee/args/6cd243def4b335efa5a83acb4d29aee482970d2e/args.hxx;
    sha256 = "0lbhqjlii0q1jdwb7pd9annhrlsfarkmdx7zbfllw5wxqrsmj8nc";
  };
in
stdenv.mkDerivation rec {
  pname = "chamferwm";
  version = "2019-03-13";
  src = fetchFromGitHub {
    owner = "jaelpark";
    repo = pname;
    rev = "bff97eb0191e35ff2fc2367f8bfad148c27c6217";
    sha256 = "1jhyr6brg3f71pz0qzkrpacrq08087gr6hi72m62wkm89ssnna6q";
  };


  postPatch = ''
    substituteInPlace src/main.cpp \
      --replace 'pconfigLoader->Run(configPath.Get().c_str(),"config.py");' \
                'pconfigLoader->Run(configPath.Get().c_str(),"${placeholder "out"}/share/chamfer/config/config.py");' \
      --replace '{"shader-path"});' \
                '{"shader-path"},"${placeholder "out"}/share/chamfer/shaders");'

    cp ${args_hxx} third/args/args.hxx
  '';

  nativeBuildInputs = [ meson ninja pkgconfig shaderc ];
  buildInputs = [
    glm
    boost
    vulkan-headers vulkan-loader
  ]
  ++ (with python3.pkgs; [ xlib psutil /* boost */ python ])
  ++ (with xorg; [ libxcb xcbutil xcbutilkeysyms xcbutilwm ]);

  # Default copies over the shaders, which is a start but.. ;)
  # Based on upstream's linked PKGBUILD:
  # https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=chamfer-git
  installPhase = ''
    install -Dm755 -t $out/bin chamfer
    install -Dm755 -t $out/share/chamfer/shaders *.spv
    install -Dm755 -t $out/share/chamfer/config ../config/*
  '';
}


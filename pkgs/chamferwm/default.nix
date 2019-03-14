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

stdenv.mkDerivation rec {
  pname = "chamferwm";
  version = "2019-03-13";
  src = fetchFromGitHub {
    owner = "jaelpark";
    repo = pname;
    rev = "bff97eb0191e35ff2fc2367f8bfad148c27c6217";
    sha256 = "1jhyr6brg3f71pz0qzkrpacrq08087gr6hi72m62wkm89ssnna6q";
  };

  nativeBuildInputs = [ meson ninja pkgconfig shaderc ];
  buildInputs = [
    glm
    boost
    vulkan-headers vulkan-loader
  ]
  ++ (with python3.pkgs; [ xlib psutil /* boost */ python ])
  ++ (with xorg; [ libxcb xcbutil xcbutilkeysyms xcbutilwm ]);
}


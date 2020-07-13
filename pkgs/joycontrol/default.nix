{ python3, fetchFromGitHub, lib }:

let
  py3 = python3.override {
    packageOverrides = self: super: {
      crc8 = import ./py-crc8.nix {
        inherit (super) fetchPypi buildPythonPackage;
        inherit lib;
      };
    };
  };
in
py3.pkgs.buildPythonApplication rec {
  pname = "joycontrol";
  version = "unstable-2020-07-11";

  src = fetchFromGitHub {
    owner = "mart1nro";
    repo = pname;
    rev = "e83dc5964b321daf9f02fea155f1dfdf394aec8b";
    sha256 = "0s2aknsssafk7riyzp71iblb7rq7myyg1aq51jc5jfdqkd3ljrnb";
  };

  buildInputs = with py3.pkgs; [ hidapi aioconsole dbus-python crc8 ];
}

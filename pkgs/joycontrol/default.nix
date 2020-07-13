{ python3, fetchFromGitHub }:

python3.pkgs.buildPythonApplication rec {
  pname = "joycontrol";
  version = "unstable-2020-07-11";

  src = fetchFromGitHub {
    owner = "mart1nro";
    repo = pname;
    rev = "e83dc5964b321daf9f02fea155f1dfdf394aec8b";
    sha256 = "0s2aknsssafk7riyzp71iblb7rq7myyg1aq51jc5jfdqkd3ljrnb";
  };
}

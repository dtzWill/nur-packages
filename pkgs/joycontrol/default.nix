{ stdenv, python3Full, fetchFromGitHub, lib, hidapi, bluez }:

let
  common = rec {
    pname = "joycontrol";
    version = "unstable-2020-07-11";
    src = fetchFromGitHub {
      owner = "mart1nro";
      repo = pname;
      rev = "e83dc5964b321daf9f02fea155f1dfdf394aec8b";
      sha256 = "0s2aknsssafk7riyzp71iblb7rq7myyg1aq51jc5jfdqkd3ljrnb";
    };
  };
  py3 = python3Full.override {
    packageOverrides = self: super: {
      crc8 = import ./py-crc8.nix {
        inherit (self) fetchPypi buildPythonPackage;
        inherit lib;
      };
      hid = import ./py-hid.nix {
        inherit (self) fetchPypi buildPythonPackage;
        inherit lib;

        # test deps
        inherit (self) nose;
        inherit hidapi;
      };

      ## library
      joycontrol = self.buildPythonPackage (common // {
        postPatch =
          # dbus-python is correctly passed in propagatedBuildInputs, but for some reason setup.py complains.
          # The wrapped terminator has the correct path added, so ignore this.
          ''
            substituteInPlace setup.py --replace "'dbus-python'," ""
          ''
          # hciconfig
          + ''
            substituteInPlace joycontrol/device.py --replace \
              "run_system_command(f'hciconfig" \
              "run_system_command(f'${bluez_with_hciconfig}/bin/hciconfig"
          '';

        propagatedBuildInputs = with py3.pkgs; [ hid aioconsole dbus-python crc8 setuptools ];
      });
    };
  };
  bluez_with_hciconfig = bluez.overrideAttrs (o: {
    configureFlags = o.configureFlags or [] ++ [ "--enable-deprecated" ];
  });
in

stdenv.mkDerivation (common // {
  dontBuild = true;
  installPhase = ''
    runHook preInstall

    install -Dm755 -t $out/bin run_controller_cli.py

    runHook postInstall
  '';

  buildInputs = [ (py3.withPackages (ps: with ps; [ joycontrol ])) ];
})

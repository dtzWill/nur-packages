{ lib, fetchFromGitHub, rustPlatform, newScope }:

let
  version = "2018-10-26";
  xi-editor-src = fetchFromGitHub {
    owner = "xi-editor";
    repo = "xi-editor";
    rev = "84f4c9477a9d443cbb65f9080ae5003cd538fa18";
    sha256 = "19spwpzj66x2nyfp51d7vmmglk3a4m0b0rn3ih4s6ax1aygbgx9c";
  };
  callPackage = newScope self;
  self = {
    xi-core = rustPlatform.buildRustPackage {
      name = "xi-core-${version}";
      inherit version;

      src = xi-editor-src;

      sourceRoot = "source/rust";

      cargoSha256 = "0mmzwzibc6rfn7y3jw7fim5xhilrbq5vbs7jkmihiq3n2zxvwaw8";

      postInstall = ''
        make -C syntect-plugin install XI_PLUGIN_DIR=$out/share/xi/plugins
        ln -vrs $out/share/xi/plugins/syntect $syntect
      '';

      outputs = [ "out" "syntect" ];

      meta = with lib; {
        description = "A modern editor with a backend written in Rust";
        homepage = https://github.com/xi-editor/xi-editor;
        license = licenses.asl20;
        maintainers = with maintainers; [ dtzWill ];
        platforms = platforms.all;
        # Not sure what version is required but 1.29 works and 1.27 doesn't
        broken =
          let
            rversion = rustPlatform.rust.rustc.version;
            oldrust = versionOlder rversion "1.29";
            maybeWarn = if oldrust then (x: warn "Rust version ${rversion} is too old for xi-editor, needs 1.29. Marking as broken accordingly." x) else id /*entity*/;
          in maybeWarn oldrust;
      };
    };
    wrapXiFrontendHook = callPackage ./wrapper.nix { };

    gxi = callPackage ./gxi { };
    kod = callPackage ./kod { };
    xi-gtk = callPackage ./xi-gtk { };
    xi-term = callPackage ./xi-term { };
  };
in self

[
  (self: super: {
    # XXX: Upgrade to (equivalent, just tagged) v2, see upstream PR
    compton-git = super.compton-git.overrideAttrs (o: rec {
      name = "compton-git-${version}";
      version = "2018-10-03";

      src = super.fetchFromGitHub {
        owner  = "yshui";
        repo   = "compton";
        rev    = "7b755a3cf01131b138282de71e5b569257565142";
        sha256 = "0gm6ga1am5cqd6c7zmjxh3jlvd967ypi0w8mn1hg23mxldlmn65g";
      };

      COMPTON_VERSION = "git-${version}-${src.rev}";

      # Default:
      #buildInputs = [
      #  dbus libX11 libXcomposite libXdamage libXrender libXrandr libXext
      #  libXinerama libdrm pcre libxml2 libxslt libconfig libGL
      #];

      buildInputs = with self; with xorg; [
        dbus libX11 libXcomposite libXext
        libXinerama libdrm pcre libxml2 libxslt libconfig libGL
        # Removed:
        # libXdamage libXrender libXrandr

        # New:
        libxcb xcbutilrenderutil xcbutilimage
        pixman libev
      ];

    });
    compton = self.compton-git;

    #light = super.light.overrideAttrs (o: rec {
    #  name = "light-${version}";
    #  version = "1.3pre";
    #  src = super.fetchFromGitHub {
    #    owner = "haikarainen";
    #    repo = "light";
    #    rev = "d75c5d4c9ce43d5845606ecc0a5e3d1e4da57287";
    #    sha256 = "1wik3qrpiqf8rm941ihqwz8pm1cdaf2gp3nviqklbb8ir7snnpig";
    #  };

    #  nativeBuildInputs = (o.nativeBuildInputs or []) ++ [ super.autoreconfHook ];

    #  buildInputs = []; # no help2man

    #  configureFlags = [ "--with-udev" ];

    #  postPatch = ''
    #    substituteInPlace 90-backlight.rules \
    #      --replace '/bin/chgrp' '${super.coreutils}/bin/chgrp' \
    #      --replace '/bin/chmod' '${super.coreutils}/bin/chmod'
    #  '';

    #  installPhase = null;
    #  preFixup = null;
    #});

    awesome = super.awesome.overrideAttrs (o: rec {
      name = "awesome-4.2-git-${version}";
      version = "2018-10-07";
      src = super.fetchFromGitHub {
        owner = "AwesomeWM";
        repo = "awesome";
        rev = "7519c6966a50994c546a56c557a21f2a87e37108";
        sha256 = "1awiam1cf7kwyd8rlcx93cmlzf1z01dd0mm8cxdjvh3faz82xs4x";
      };
      #postPatch = (o.postPatch or "") + ''
      #  substituteInPlace lib/menubar/icon_theme.lua \
      #    --replace 'icon_size or 16' '128'
      #'';
    });

    sddm = super.sddm.overrideAttrs (o: rec {
      name = "sddm-${version}";
      version = "2018-09-10";
      src = super.fetchFromGitHub {
        owner = "sddm";
        repo = "sddm";
        rev = "76a9fcf3cd4eb0cd7a7ad50c53cc6624a5b35626";
        sha256 = "1qqv8d5gxppmk0h6n98dwwdly1wzq3z2lrk4d63fchdym9hn35gg";
      };
      patches = [ <nixpkgs/pkgs/applications/display-managers/sddm/sddm-ignore-config-mtime.patch> ];

      postInstall = ''
        echo "Skipping postInstall from normal sddm...."
      '';
    });

    nix-zsh-completions = super.nix-zsh-completions.overrideAttrs (o: rec {
      name = "nix-zsh-completions-${version}";
      version = "0.4.0.1"; # not really
      src = super.fetchFromGitHub {
        owner = "spwhitt";
        repo = "nix-zsh-completions";
        rev = "13a5533b231798c2c8e6831e00169f59d0c716b8";
        sha256 = "1xa1nis1pvns81im15igbn3xxb0mhhfnrj959pcnfdcq5r694isj";
      };
    });

    zsh-autosuggestions-dev = super.zsh-autosuggestions.overrideAttrs (o: rec {
      name = "zsh-autosuggestions-${version}";
      version = "0.4.3.1"; # not really
      src = super.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-autosuggestions";
        rev = "fa5d9c0ff5fb202545e12c98dae086d91d70ba50"; #"v${version}";
        sha256 = "0mk53kgvxbw8fxcj9l17jg0dmvibpq4pc5ylc7zjd6m62glik6nh";
      };
    });

    powertop = super.powertop.overrideAttrs (o: rec {
      name = "powertop-2.9.0.1"; # not really
      nativeBuildInputs = (o.nativeBuildInputs or []) ++ [ self.autoreconfHook self.git ];
      src = super.fetchgit {
        url = "https://github.com/fenrus75/powertop";
        rev = "6f5edbcf4d45b8814e2d7b0fc0fe9774aafd44c1";
        sha256 = "0lsxx161yql930yl9333yxfnamm2dl14bsab2qlfn15sxbkzl0fs";
        leaveDotGit = true;
      };

      postPatch = (o.postPatch or "") + ''
        chmod +x scripts/version
        patchShebangs ./scripts/version

        ./scripts/version
      '';
    });

    tlp = super.tlp.overrideAttrs (o: rec {
      name = "tlp-${version}";
      version = "2018-10-03";
      src = super.fetchFromGitHub {
        owner = "linrunner";
        repo = "tlp";
        rev = "b6dac68eb414a1f5cb38641893aa6fea8c2e4332";
        sha256 = "03sfbcs7050x0wgdhqqsw70by20299i4vzrm337j366mgx9mbxk4";
      };
    });

    #libinput = super.libinput.overrideAttrs (o: rec {
    #  name = "libinput-${version}";
    #  version = "1.12.0";
    #  src = super.fetchurl {
    #    url = "https://www.freedesktop.org/software/libinput/${name}.tar.xz";
    #    sha256 = "1901wxh9k8kz3krfmvacf8xa8r4idfyisw8d80a2ql0bxiw2pb0m";
    #  };
    #  # patches = [ ./udev-absolute-path.patch ];
    #  postPatch = ''
    #    substituteInPlace meson.build --replace udev_dir dir_udev
    #  '';

    #  preBuild = null;
    #});

    #lm_sensors = super.lm_sensors.overrideAttrs (o: rec {
    #  name = "lm-sensors-${version}";
    #  version = "3.4.0.0.1"; # XXX not really

    #  patches = [];

    #  src = super.fetchFromGitHub {
    #    owner = "lm-sensors";
    #    repo = "lm-sensors";
    #    rev = "38220cc2e97215588b662584d6ad84d63415842f";
    #    sha256 = "1f4wr8yc3bncgnzm5vlhr1f0c9hc0llk3i7h8b5w2v292qwdvilg";
    #  };
    #});
  })

  (self: super: {
    #weechat-dtz = super.weechat.override {
    #  configure = {availablePlugins, ...}: {
    #    plugins = with availablePlugins; [ lua perl
    #      (python.withPackages (ps: with ps; [websocket_client xmpppy]))                                                                                                                                            
		#		];
		#		extraBuildInputs = [ super.luaPackages.cjson ];
    #    scripts = with super.weechatScripts; [
    #      weechat-xmpp weechat-matrix-bridge wee-slack
    #    ];
    #  };
    #};

    isync = super.isyncUnstable.overrideAttrs (o: rec {
      name = "isync-git-${version}";
      version = "2018-07-01";
      src = super.fetchgit {
        url = "https://git.code.sf.net/p/isync/isync";
        rev = "37feeddbfb8d86fcd25f90c7928d5ea139b0feb4";
        sha256 = "0hsk1x8wsbpccj9xnd8dy5qx3scr1gwmdmpp0g08gmlbwkzkx73h";
      };
    });

    #nheko = super.nheko.overrideAttrs(o: rec {
    #  name = "nheko-${version}";
    #  version = "2018-10-04";
    #  src = super.fetchFromGitHub {
    #    owner = "mujx";
    #    repo = "nheko";
    #    rev = "420937ab8337f181105a571cdcb33d4d05091ed5";
    #    sha256 = "0hx1pglj9433885w5ncrbg51zf4sccmlk5rchl37si40mrsg5qfm";
    #  };
    #});

    arc-icon-theme = super.arc-icon-theme.overrideAttrs(o: rec {
      name = "arc-icon-theme-2017-06-17";
      src = super.fetchFromGitHub {
        owner = "arc-theme";
        repo = "arc-icon-theme";
        rev = "ec0f4f4c18d2391428dd59732a77437c9ce22597";
        sha256 = "10vf5jqki7n88bbz51l87jb90dfycshpqzar31nz2jsg5kf1qz9w";
      };
    });

    #elementary-
    elementary-icon-theme = super.elementary-icon-theme.overrideAttrs(o: rec {
      name = o.name + "-git";
      src = super.fetchFromGitHub {
        owner = "elementary";
        repo = "icons";
        rev = "8afc3260c031ff045c6aa1d7c5599226b41c3e70";
        sha256 = "0ab7a8c6s29xh4z7p71gr1r778mw5v212jjsr0l867zilgnjkcam";
      };

      nativeBuildInputs = with self; [ meson ninja python3 ];
      buildInputs = [ self.gtk3 ];
      postPatch = ''
        chmod +x ./meson/*
        patchShebangs ./meson/
      '';
      # Don't install these into root prefix (?!)
      mesonFlags = [ "-Dvolume_icons=false" ];
      postFixup = null;
    });
    elementary-gtk-theme = super.elementary-gtk-theme.overrideAttrs(o: rec {
      name = o.name + "-git";
      src = super.fetchFromGitHub {
        owner = "elementary";
        repo = "stylesheet";
        rev = "d8be6eb36531e347e777f412f6f0d8af05553371";
        sha256 = "106lsayy6gcwfnv7ixxm7lgzwyi57by0sa37rzw9naa8fr7a2ki5";
      };

      nativeBuildInputs = with self; [ meson ninja ];
      buildInputs = [ self.gtk3 ];
      installPhase = null;
      dontBuild = false;
    });

    valgrind = super.valgrind.overrideAttrs(o: rec {
      name = "valgrind-3.14.0.RC2";
      src = super.fetchgit {
        url = "git://sourceware.org/git/valgrind.git";
        rev = "d2af42d826d65f3a6722a33309e721264846efd3"; # not tagged, idk
        sha256 = "1zajcbnv1f3j2brxhmcjhml15nr3n956ws96467c49j8hnn2jzc0";
      };

      nativeBuildInputs = (o.nativeBuildInputs or []) ++ [ self.autoreconfHook ];

      outputs = [ "out" "dev" /* "man" "doc" */ ]; # idk why
    });

    fwupd = super.fwupd.overrideAttrs(o: rec {
      name = "fwupd-${version}";
      version = "2018-10-02";

      src = super.fetchFromGitHub {
        owner = "hughsie";
        repo = "fwupd";
        rev = "55ab100334ad0b441e3b44c1f8cae125f40e7e3d";
        sha256 = "1m6jny9w3bc9b0d8cv0czcaf99ky9g0mv5bxmkcvrkzdx4zqgwbd";
      };
    });
  })
]

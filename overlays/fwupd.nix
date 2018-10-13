self: super: {
  fwupd = super.fwupd.overrideAttrs(o: rec {
    name = "fwupd-${version}";
    version = "2018-10-12";

    src = super.fetchFromGitHub {
      owner = "hughsie";
      repo = "fwupd";
      rev = "802a279bd2b53e59f1d1d363c2d106e59b59b6fb";
      sha256 = "0b7l1v1sirxz04pf8g8mid6kpyyzxbazjj15crmb3brzv8jpz5fa";
    };

    # Original:
    #buildInputs = [
    #  polkit appstream-glib gusb sqlite libarchive libsoup elfutils libsmbios gnu-efi libyaml
    #  libgudev colord gpgme libuuid gnutls glib-networking efivar json-glib umockdev
    #  bash-completion
    #];
    buildInputs = with self; [
      # Removed:
      # appstream-glib
      # Remaining:
      polkit gusb sqlite libarchive libsoup elfutils libsmbios gnu-efi libyaml
      libgudev colord gpgme libuuid gnutls glib-networking efivar json-glib umockdev
      bash-completion
    ];

  });
}

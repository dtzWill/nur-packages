{
  allvm-cache = ./allvm-cache.nix; # largely deprecated in favor of cachix
  allvm-cachix = ./allvm-cachix.nix;

  chromecast-firewall-exceptions = ./chromecast-firewall-exceptions.nix;

  # Convenience module
  dwarffs = ./dwarffs.nix;

  nix-dtz = ./nix-dtz.nix;
  nix-dtz-musl = ./nix-dtz-musl.nix;

  vim-manpager = ./vim-manpager.nix;
}

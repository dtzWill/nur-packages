
let
  narurl = "nar/0f77fc768873b0a53b40ca034404a814085650ab74fd687067effda9198fdd58.nar.xz";
  narHash = "sha256:0hnr7awn64a9kjninnbkcav9cl3k2bwkxk25qk0z9dk1f69qf36r";
  downloadHash = "sha256:0n6xiwcskzggcxq6izblmd85c20lm02480ya80xsbc3ki1vgqxqg";
  path = "/nix/store/92j9gh698w55wnq3hv40lf7d3d5m8w6w-allvm-tools-bins";

in import <nix/fetchurl.nix> {
  url = "https://allvm.cachix.org/${narurl}";
  unpack = true;
  name = "allvm-tools-bins";

  sha256 = narHash; # downloadHash;
}

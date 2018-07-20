{ lib }:
(lib.from-nar {
  name = "allvm-tools-bin";
  narurl = "nar/0f77fc768873b0a53b40ca034404a814085650ab74fd687067effda9198fdd58.nar.xz";
  narHash = "sha256:0hnr7awn64a9kjninnbkcav9cl3k2bwkxk25qk0z9dk1f69qf36r";
}) // {
  meta = with lib; {
    description = "ALLVM Tools (multiplexed)";
    maintainers = with maiintainers; [ dtzWill ];
    license = licenses.ncsa;
    homepage = https://github.com/allvm/allvm-tools;
  };
}

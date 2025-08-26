with import <nixpkgs> { };

pkgs.buildFHSEnv {
  name = "gns3";

  targetPkgs = pkgs: with pkgs; [
    # Основные зависимости GNS3
    gns3-gui
    gns3-server
    wireshark
    dynamips
    qemu
    vpcs
    ubridge
  ];

  multiPkgs = pkgs: with pkgs; [
    glibc
  ] ++ (with pkgs.pkgsi686Linux; [
    glibc
  ]);

  runScript = "gns3";
}


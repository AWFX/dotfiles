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

    # Базовые библиотеки
    python3
    udev
    libvirt
    openssl
    iproute2
    iptables
    netcat
    socat
    bridge-utils
    openvpn
  ];

  multiPkgs = pkgs: with pkgs; [
    # 64-битные библиотеки для GUI и сетей
    qt5.full
    gtk3
    cairo
    pango
    gdk-pixbuf
    glibc
    libGL
    libGLU
    libpcap
    libuuid
    zlib
    bzip2
  ] ++ (with pkgs.pkgsi686Linux; [
    # 32-битные аналоги, если понадобятся
    libGL
    libGLU
    libpcap
    zlib
    bzip2
    glibc
    djgpp_i686
  ]);

  runScript = "gns3";
}


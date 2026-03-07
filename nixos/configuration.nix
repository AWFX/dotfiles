{ config, lib, pkgs, ...}:

{
  imports = [
    ./hardware-configuration.nix
#    ./software.nix
  ];
  
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
        Policy = {
        AutoEnable = true;
      };
    };
  };

  services.blueman.enable = true;
#  services.netbird.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable ntfs support.
  boot.supportedFilesystems = [ "ntfs" ];

  boot.kernel.sysctl = {
    "kernel.printk" = "3 4 1 4";
  };


  # Enable basic virtualization.
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

  boot.extraModulePackages = with config.boot.kernelPackages ; [ amneziawg ]; 
  

  # Networking.
  networking = {
    hostName = "laptop";
    networkmanager.enable = true;
    networkmanager.dns = "none";
    nameservers = [ "127.0.0.1" ];
  };

  services.dnsmasq = {
    enable = true;
    settings.server = [
      "/corp.w77w.ru/192.168.0.2"
      "1.1.1.1"
      "192.168.0.1"
      "8.8.8.8"
    ];
  };


  services.logind.settings.Login = {
    HandlePowerKey= "ignore";
    HandlePowerKeyLongPress= "ignore";
 #   HandleLidSwitch=hibernate;
    PowerKeyIgnoreInhibited = true;
  };
  

  # Set time zone.
  time.timeZone = "Asia/Yekaterinburg";
  
  # Add zsh in system.
  programs.zsh = {
    enable = true;
    shellAliases = {
      v = "vim";
      ll = "ls -lh";
      gst = "git status";
      rebuild = "sudo nixos-rebuild switch";
      "ip a" = "ip -br -c a";
      ff = "fastfetch";
      duf = "duf -only local --hide-mp /nix/store --output mountpoint,size,used,avail,usage,type";
      addr = "ip -br -c -4 a";
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
  };

  # User account.
  users.users.loylifer = {
    isNormalUser = true;
    extraGroups = [ 
    "wheel"  
    "networkmanager"
    "docker"
    "audio"
    ];

    shell = pkgs.zsh;
  };

  security.sudo.extraRules = [
    { users = [ "loylifer" ];
      commands = [ {command = "ALL"; options = [ "NOPASSWD" ]; } ];
    }
  ];

  nixpkgs.config.permittedInsecurePackages = [
                "beekeeper-studio-5.3.4"
              ];

  nixpkgs.config.allowUnfree = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

#  virtualisation.docker.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "loylifer" ]; 


  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true;
  dedicatedServer.openFirewall = true;
  localNetworkGameTransfers.openFirewall = true;
};

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    font-awesome
    times-newer-roman
    liberation_ttf

    dejavu_fonts
    liberation_ttf
    cantarell-fonts
    ubuntu-classic
    roboto
    inter
    source-sans-pro
    open-sans
    lora
    merriweather
    fira
    ];
  
  # Install pkgs.
  environment.systemPackages = with pkgs; [
    home-manager
    libsForQt5.qt5.qtbase
    hyprlock
    hypridle
    wlogout
    neovim
    docker
    docker-compose
    kitty
    git
    wget
    fastfetch
    xfce.thunar
    google-chrome
    swww
    wofi
    telegram-desktop
    vscode
    obsidian
    dbeaver-bin
    beekeeper-studio
    wireguard-tools
    qbittorrent
    zsh
    lightdm
    brightnessctl
    python313
    grim
    slurp
    pavucontrol
    wl-clipboard
    vagrant
    btop
    nwg-look
    pywal
    busybox
    udiskie
    duf
    mako
    timeshift
    networkmanagerapplet
    libreoffice-qt6-fresh
    hplip
    pantheon.switchboard-plug-printers
    cups
    discord
    terminal-parrot
    gcc
    termius
    bluetui
    firefox
    vim
    sl
    cmatrix
    asciiquarium
    bundler
    nmap
    qview
    feh
    imv
    bash
    amnezia-vpn
    amneziawg-tools
    linuxKernel.packages.linux_zen.amneziawg
    amneziawg-go
    kdePackages.kpat
    cool-retro-term
    cliphist
    xwayland
    xkeyboard_config
    libxkbcommon
    putty
    gimp
    waybar
    calc
    netdiscover
    obs-studio
    dig
    dirbuster
    dirstalk
    dirb
    dnsenum
    dnsrecon
    dnsmap
    kodi-wayland
    vlc
    tcpdump
    terraform
    drawio
    remmina
    x2goclient
    virt-viewer
    postman
    nodejs
    gns3-gui
    gns3-server
    vpcs
    code-cursor
    cursor-cli
    stow
    hyprpolkitagent
    spotify
    netbird
    netbird-ui
    postgresql
    tmux
    pgadmin4
    nosql-booster
    unrar
    instaloader
    zip
    gallery-dl
    eog
    certbot
    amnezia-vpn
    brave
    yt-dlp
    wireshark
    dnsmasq
    openvpn3
  ];

  # Login manager
  services.greetd.enable = true;
  services.greetd.settings = {
#    default_session = "hyprland";
#    initial_session = "hyprland";
    default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --time --cmd Hyprland";
    };
  };
  services.udisks2.enable = true;
  services.devmon.enable = true;

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  environment.variables = {
    VAGRANT_DISABLE_STRICT_DEPENDENCIES = "1";
  };
  
#  networking.firewall = {
#  enable = true;
#  allowedTCPPorts = [ 5173 5174 8000 8273 8443];
#};

  system.stateVersion = "22.05";
}

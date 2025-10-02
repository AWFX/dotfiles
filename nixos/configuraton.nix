{ config, lib, pkgs, ...}:

{
  imports = [
    ./hardware-configuration.nix
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


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Enable ntfs support.
  boot.supportedFilesystems = [ "ntfs" ];

  # Enable basic virtualization.
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

  # Networking.
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  networking.extraHosts =
    ''
     10.1.1.100 gitlab.com
     192.168.0.100 msi zvirt.local
    '';

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
      duf = "duf -only local";
    };
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
                "beekeeper-studio-5.1.5"
              ];

  nixpkgs.config.allowUnfree = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  virtualisation.docker.enable = true;

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

    dejavu_fonts
    liberation_ttf
    cantarell-fonts
    ubuntu_font_family
    roboto
    inter
    source-sans-pro
    open-sans
    lora
    merriweather
    ];
  
  # Install pkgs.
  environment.systemPackages = with pkgs; [
    home-manager
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
    openssh
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
    spotify
    lightdm
    brightnessctl
    python313
    grim
    slurp
    pavucontrol
    wl-clipboard
    vagrant
    waybar
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
    ruby_3_4
    nmap
  ];

  services.udisks2.enable = true;
  services.devmon.enable = true;

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  system.stateVersion = "22.05";
}

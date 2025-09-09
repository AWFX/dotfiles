{ config, lib, pkgs, ...}:

{
  imports = [
    ./hardware-configuration.nix
  ];


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
  
  # Set time zone.
  time.timeZone = "Asia/Yekaterinburg";
  
  # Add zsh in system.
  programs.zsh = {
    enable = true;
  };

  # User account.
  users.users.loylifer = {
    isNormalUser = true;
    extraGroups = [ 
    "wheel"  
    "networkmanager"
    "docker"
    "ubridge"
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


  users.groups.ubridge = {};
#  users.users.loylifer.extraGroups = [ "ubridge" ];

  users.groups.gns3 = { };
  users.users.gns3 = {
    group = "gns3";
    isSystemUser = true;
  };

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    font-awesome
    ];
  
  # Install pkgs.
  environment.systemPackages = with pkgs; [
    home-manager
    hyprlock
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

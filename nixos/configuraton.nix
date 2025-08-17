{ config, lib, pkgs, ...}:

  imports = [
    ./hardware-configuration.nix
  ];

# Use the systemd-boot EFI boot loader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

# Networking.
networking.hostName = "laptop";
networking.networkmanager.enable = true;

# Set time zone.
time.timeZone = "Asia/Yekaterinburg";

# User account.
users.users.loylifer = {
  isNormalUser = true;
  extraGroups = [ "wheel" ];
};

nixpkgs.config.allowUnfree = true;
programs.hyprland.enable = true;

# Install pkgs.
environment.systemPackages = with pkgs; [
  neovim
  wget
  firefox
  virtualbox
  kitty
  openssh
  google-chrome
];

# Enable the OpenSSH daemon.
services.openssh = {
  enable = true;
  settings = {
    Port = 22;
    PermitRootLogin = "yes";
  };
};

system.stateVersion = "22.05";

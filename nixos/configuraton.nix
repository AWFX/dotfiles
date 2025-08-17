{ config, lib, pkgs, ...}:

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

# Install pkgs.
environment.systemPackages = with pkgs; [
  neovim
  wget
  firefox
  virtualbox
  hyprland
  openssh
  google-chrome
  vagrant
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

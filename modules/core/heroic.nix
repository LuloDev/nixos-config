{ pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [
    heroic
    mangohud    # Show FPS
    gamemode    # CPU/GPU optimice
  ];
}

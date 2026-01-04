{
  pkgs,
  inputs,
  username,
  host,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };
    users.${username} = {
      imports =
        if (host == "desktop") then
          [
            inputs.catppuccin.homeModules.catppuccin
            ./../home/default.desktop.nix
          ]
        else
          [
          inputs.catppuccin.homeModules.catppuccin
          ./../home
          ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
    backupFileExtension = "hm-backup";
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };
  nix.settings.allowed-users = [ "${username}" ];
}

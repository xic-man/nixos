{ config, pkgs, ... }:

{
  config = {
    users.users.xic = {
      isNormalUser = true;
      description = "Xavier Cohen";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    programs.steam.enable = true;

    home-manager.useUserPackages = true;
    home-manager.users.xic = {
      home = {
        username = "xic";
        homeDirectory = "/home/xic";
        stateVersion = "22.11";
      };

      programs = {
        home-manager = {
          enable = true;
        };

        # CLI
        gnome-terminal = {
          enable = true;

          profile.xic = {
            visibleName = "xic";
            default = true;
          };
        };

        tmux.enable = true;
        git.enable = true;

        # IDE
        vscode = {
          enable = true;
          package = pkgs.vscodium;
        };

        # GUI
        firefox = {
          enable = true;
          extensions = with config.nur.repos.rycee.firefox-addons; [
            ublock-origin
            https-everywhere
          ];
          profiles.default = {
            id = 0;
            name = "Default";
            isDefault = true;
          };
        };
      };
    };
  };
}

{
  outputs = { self }: {
    nixosModules = {
      hmModule = { config, lib, ... }:
        with lib;
        let cfg = config.programs.zsh.johnnydecimal;
        in {
          options = {
            programs.zsh.johnnydecimal = {
              enable = mkEnableOption "zsh-johnnydecimal";
              basePath = mkOption {
                type = types.path;
                default = "~/johnny/";
                description = "Path to the root of the J.D structure";
              };
            };
          };

          config = mkIf cfg.enable {
            programs.zsh.plugins = [{
              name = "zsh-johnnydecimal";
              file = "johnnydecimal.zsh";
              src = ./.;
            }];

            home.sessionVariables = {
              "JOHNNYDECIMAL_BASE" = cfg.basePath;
            };
          };
        };

      globalModule = {config, ...}: {
        home-manager.sharedModules = [ self.nixosModules.hmModule ];
      };

      default = self.nixosModules.globalModule;
    };
  };
}

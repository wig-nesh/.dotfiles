{
  flake.nixosModules.user =
    { config
    , lib
    , pkgs
    , ...
    }:
    let
      cfg = config.preferences.user;
    in
    {
      options.preferences.user = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "wignesh";
        };

        fullName = lib.mkOption {
          type = lib.types.str;
          default = "Vignesh Vembar";
        };

        email = lib.mkOption {
          type = lib.types.str;
          default = "vigneshvembar.m@students.iiit.ac.in";
        };

        extraGroups = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };

        extraOptions = lib.mkOption {
          type = lib.types.attrs;
          default = { };
        };

        sshKeys = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };

        password = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
        };

        useSopsPassword = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = ''
            Whether to source user and root hashed passwords from sops.
            Disable on hosts that do not import the sops module.
          '';
        };
      };

      config =
        {
          programs.zsh.enable = true;

          users.users.${cfg.name} = {
            isNormalUser = true;
            createHome = true;
            home = "/home/${cfg.name}";
            group = "users";
            shell = pkgs.zsh;
            uid = 1000;
            inherit (cfg) extraGroups;
            openssh.authorizedKeys.keys = cfg.sshKeys;
            password = lib.mkIf (cfg.password != null) cfg.password;
          }
          // cfg.extraOptions;
        }


      ;
    };
}

{
  flake.nixosModules.wine =
    { pkgs
    , lib
    , ...
    }:
    {
      programs.gamemode.enable = true;
      services.ratbagd.enable = true;
      programs.gamescope = {
        enable = true;
        capSysNice = false;
      };

      environment.systemPackages = with pkgs; [
        lutris
        steam
        (lib.hiPrio (writeShellScriptBin "steam" ''
          export XDG_SESSION_TYPE=x11
          export DISPLAY=:1
          exec ${lib.getExe steam} "$@"
        ''))
      ];

    };
}

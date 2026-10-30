{ inputs, ... }:
{
  flake.homeModules.niri =
    { pkgs
    , ...
    }:
    {
      imports = [
        inputs.niri-flake.homeModules.niri

        ./_binds.nix
        ./_settings.nix
        ./_rules.nix
      ];
      programs.niri = {
        enable = true;
        # stable niri from nixpkgs (cached on cache.nixos.org); niri-flake is only
        # used for its home module. unstable was: inputs.niri-flake.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable
        package = pkgs.niri;
      };

      home.packages = with pkgs; [
        brightnessctl
        wl-clipboard
      ];

      systemd.user.services.xwayland-satellite = {
        Unit = {
          Description = "Xwayland Satellite";
          After = [ "graphical-session.target" ];
        };
        Install.WantedBy = [ "graphical-session.target" ];
        Service = {
          ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
          Restart = "on-failure";
        };
      };

      services.playerctld.enable = true;
    };
}

{ inputs, ... }:
{
  flake.nixosModules.nix =
    { pkgs
    , ...
    }:
    {
      environment.systemPackages = with pkgs; [
        nix-health
        nix-index
        nix-output-monitor
        nix-prefetch-git
      ];

      nixpkgs.config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-40.10.5"
          # (zotero off) bundled firefox ESR 140 (EOL 2026-10-13); drop once nixpkgs updates zotero
          # "firefox-esr-140-bin-unwrapped-140.17.0esr"
        ];
      };

      nix = {
        package = pkgs.nixVersions.latest;
        gc = {
          options = "--keep 10";
          dates = "daily";
          automatic = true;
        };

        settings = {
          extra-substituters = [
            "https://nix-community.cachix.org"
            "https://noctalia.cachix.org"
          ];
          extra-trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
          ];
          trusted-users = [
            "root"
            "@wheel"
          ];
          sandbox = true;
          auto-optimise-store = true;
          cores = 6;
          allowed-users = [
            "root"
            "@wheel"
          ];
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          http-connections = 50;
          warn-dirty = false;
          log-lines = 50;
        };
      };

      # System AutoUpgrade
      system.autoUpgrade = {
        enable = true;
        flake = inputs.self.outPath;
        flags = [
          "-L" # print build logs
        ];
        dates = "05:00";
        randomizedDelaySec = "45min";
      };
    };
}

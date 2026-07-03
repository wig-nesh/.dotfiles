{
  flake.homeModules.office-bundle =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        evince
        libreoffice
        obsidian
        signal-desktop
        vesktop
      ];
    };
}

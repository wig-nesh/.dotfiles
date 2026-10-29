{ self, inputs, ... }:
{
  flake.homeModules.wignesh-wignesh =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.common-bundle
        self.homeModules.desktop-bundle
        self.homeModules.development-bundle
        self.homeModules.office-bundle
        self.homeModules.shell-bundle

        # self.homeModules.hyprland
        self.homeModules.niri

        self.homeModules.firefox
        self.homeModules.spotify # spicetify; replaced by spotifast
        self.homeModules.yazi

        # self.homeModules.rclone
      ];
      # home.packages = [
      #   inputs.spotifast.packages.${pkgs.stdenv.hostPlatform.system}.default
      # ];
      home.stateVersion = "26.05";
    };
}

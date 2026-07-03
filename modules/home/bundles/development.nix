{ self, inputs, ... }:
{
  flake.homeModules.development-bundle =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        # self.homeModules.atuin
        self.homeModules.direnv
      ];

      home.packages = with pkgs; [
        vscode

        caligula
        nvitop
        gh

        gemini-cli
        codex
        opencode

        # antigravity
        inputs.antigravity-nix.packages.${pkgs.stdenv.system}.default
        # inputs.antigravity-nix.packages.${pkgs.stdenv.system}.google-antigravity-ide
        inputs.antigravity-nix.packages.${pkgs.stdenv.system}.google-antigravity-cli

        # python
        uv

        # Notes
        obsidian
        zotero

        # robotics
        arduino-cli
        minicom
      ];

    };
}

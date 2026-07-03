{
  flake.homeModules.kitty =
    {
      lib,
      ...
    }:
    {

      home.sessionVariables = {
        TERMINAL = "kitty";
      };

      programs.kitty = {
        enable = true;
        themeFile = "Catppuccin-Mocha";
        font.size = lib.mkForce 14;
        font.name = lib.mkForce "JetBrainsMono Nerd Font";
        shellIntegration.enableZshIntegration = true;
        settings = {
          enable_audio_bell = false;
          window_padding_width = 5;
          copy_on_select = false;
          clipboard_control = "write-clipboard read-clipboard write-primary read-primary";
          active_border_color = "None";
        };
      };
    };
}

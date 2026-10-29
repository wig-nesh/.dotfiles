{
  flake.homeModules.zsh =
    {
      config,
      lib,
      ...
    }:
    {
      programs.zsh = {
        enable = true;
        dotDir = "${config.xdg.configHome}/zsh";
        defaultKeymap = "emacs";
        historySubstringSearch = {
          enable = true;
          # searchDownKey = [ "$terminfo[kcud1]" ];
          # searchUpKey = [ "$terminfo[kcuu1]" ];
        };
        history = {
          size = 100000;
          save = 100000;
          path = "$HOME/.zsh_history";
          append = true;
          share = true;
          ignoreSpace = true;
          ignoreAllDups = true;
          saveNoDups = true;
          ignoreDups = true;
          findNoDups = true;
        };
        setOptions = [ "NO_BEEP" ];
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
          ls = "eza";
          cat = "bat";
          man = "batman";
          update = "nix flake update --flake ~/.dotfiles";
          rebuild = "nh os switch ~/.dotfiles/";
          clean = "nh clean all -k 5";
          rm = "trash";
        };
        initContent = lib.mkAfter ''
          ${builtins.readFile ./.zshrc}
          vpn() {
            nmcli connection up "linux" --ask
            sudo ip route del default via 10.15.0.1 dev tun0 2>/dev/null
          }
          vpn-down() {
            nmcli connection down "linux"
          }
        '';
      };
    };
}

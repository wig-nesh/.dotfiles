{
  flake.homeModules.ssh =
    {
      config,
      lib,
      ...
    }:
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings = {
          "*" = {
            ## FOR SAFETY, DO NOT OVERRIDE !! ##
            ForwardAgent = lib.mkForce false;
            HashKnownHosts = lib.mkForce true;

            AddKeysToAgent = "yes";
            ServerAliveInterval = 60;
            ServerAliveCountMax = 10;
            Compression = false;
            UserKnownHostsFile = "~/.ssh/known_hosts";
            ControlMaster = "auto";
            ControlPath = "~/.ssh/master-%r@%n:%p";
            ControlPersist = "no";

            SetEnv = {
              TERM = "xterm-256color";
            };
          };

          "github.com" = {
            User = "git";
            HostName = "ssh.github.com";
            IdentityFile = "${config.home.homeDirectory}/.ssh/id_github";
            IdentitiesOnly = true;
            Port = 443;
          };

          "orion" = {
            User = "dualarm";
            HostName = "orion.rrcx.tk";
            IdentityFile = "${config.home.homeDirectory}/.ssh/id_orion";
            IdentitiesOnly = true;
          };

          "spectre" = {
            User = "dualarm";
            HostName = "spectre.rrcx.tk";
            IdentityFile = "${config.home.homeDirectory}/.ssh/id_spectre";
            IdentitiesOnly = true;
          };

        };
      };
      services.ssh-agent.enable = true;
    };
}

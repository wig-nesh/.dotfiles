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
        includes = [ "~/.brev/ssh_config" ];
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

          "enigma" = {
            User = "dynamic-grasping";
            HostName = "enigma.rrcx.tk";
            IdentityFile = "${config.home.homeDirectory}/.ssh/id_enigma";
            IdentitiesOnly = true;
          };

          "enigma_da" = {
            User = "dualarm";
            HostName = "enigma.rrcx.tk";
            IdentityFile = "${config.home.homeDirectory}/.ssh/id_enigma_da";
            IdentitiesOnly = true;
          };
          
          "mechlab" = {
            User = "mtronlab";
            HostName = "10.2.129.231";
            IdentityFile = "${config.home.homeDirectory}/.ssh/id_mechlab";
            IdentitiesOnly = true;
          };
          
          "ada" = {
            HostName = "ada-gw1.iiit.ac.in";
            User = "ayushk02";
          };

          "gnode117" = {
            HostName = "gnode117";
            User = "ayushk02";
            ProxyCommand = "ssh -W %h:%p ada";
          };

          "jhu" = {
            HostName = "login.arch.jhu.edu";
            User = "mkarim9";
            IdentityFile = "${config.home.homeDirectory}/.ssh/id_jhufaizal";
            ControlMaster = "auto";
            ControlPersist = "24h";
            ControlPath = "~/.ssh/cm/%C";
            ServerAliveInterval = 60;
          };

          "jhu-node" = {
            HostName = "gl110";
            User = "mkarim9";
            IdentityFile = "${config.home.homeDirectory}/.ssh/id_jhufaizal";
            ProxyJump = "jhu";
            StrictHostKeyChecking = "no";
            UserKnownHostsFile = "/dev/null";
          };
        };

      };
      services.ssh-agent.enable = true;
    };
}

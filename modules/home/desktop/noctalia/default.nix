{ inputs, ... }:
{
  flake.homeModules.noctalia =
    {
      config,
      ...
    }:
    let
      home = config.home.homeDirectory;
      terminalChoice =
        if config.programs.kitty.enable then
          "kitty"
        else if config.programs.ghostty.enable then
          "ghostty"
        else
          "xterm";
      scripts = "${home}/.dotfiles/modules/home/programs/waybar";
    in
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      home.file.".face".source = ./face.png;

      # v5 wraps Terminal=true apps in $TERMINAL (v4 appLauncher.terminalCommand)
      home.sessionVariables.TERMINAL = terminalChoice;

      # noctalia v5, ported from the v4 (quickshell) config kept in ./_v4.nix
      programs.noctalia = {
        enable = true;

        settings = {
          shell = {
            avatar_path = "${home}/.face";
            telemetry_enabled = false;
            clipboard_enabled = true;
            animation = {
              enabled = true;
              speed = 1.0;
            };
            panel = {
              transparency_mode = "soft"; # v4 translucentWidgets + 0.93 panel opacity
              borders = false; # v4 boxBorderEnabled = false
              shadow = false; # v4 enableShadows = false
              launcher_position = "center";
            };
            launcher = {
              sort_by_usage = true;
              app_grid = true; # v4 viewMode = "grid"
              categories = true;
              providers.session.global = true; # v4 enableSessionSearch
            };
          };

          # theme (palette, dark mode, font, default wallpaper) comes from stylix

          wallpaper = {
            enabled = true;
            fill_mode = "crop";
            fill_color = "#000000";
            directory = ""; # XDG Pictures (v4 pointed at a dir that doesn't exist here)
            transition = [
              "fade"
              "disc"
              "stripes"
              "wipe"
              "pixel"
              "honeycomb"
            ];
            transition_duration = 1500;
            transition_on_startup = true; # v4 skipStartupTransition = false
            automation = {
              enabled = false;
              interval_seconds = 300;
              order = "random";
            };
          };

          lockscreen = {
            enabled = true;
            blur_intensity = 0.2;
            tint_intensity = 0.0;
          };

          notification = {
            enable_daemon = true;
            layer = "overlay"; # v4 overlayLayer
            keep_dismissed_in_history = true;
          };

          osd = {
            position = "bottom_center";
            hide_delay_ms = 2000;
          };

          location = {
            auto_locate = false;
            address = "Hyderabad";
          };

          weather = {
            enabled = true;
            unit = "celsius";
            effects = true;
          };

          control_center = {
            # v5 allows 6 shortcuts; v4's 7th was nightlight
            shortcuts = [
              { type = "wifi"; }
              { type = "bluetooth"; }
              { type = "wallpaper"; }
              { type = "notification"; }
              { type = "power_profile"; }
              { type = "caffeine"; }
            ];
            media.show_visualizer = false;
          };

          bluetooth.connect_when_enabled = true; # v4 bluetoothAutoConnect
          nightlight.enabled = false;
          dock.enabled = false;
          desktop_widgets.enabled = false;

          # hypridle owns idle/lock timeouts
          idle.behavior = {
            lock.enabled = false;
            screen-off.enabled = false;
          };

          bar.main = {
            position = "top";
            background_opacity = 0.93;
            radius = 12;
            margin_edge = 4;
            margin_ends = 8;
            thickness = 38;
            widget_spacing = 10;
            shadow = false;

            # every widget gets its own pill so they read as separate items
            capsule = true;
            capsule_padding = 8;
            capsule_opacity = 0.9;
            auto_hide = false;
            reserve_space = true;

            start = [
              "clock"
              "group:sysmon"
              "media"
            ];
            # workspace numbers; hovering unfolds the per-workspace app icons (accordion group)
            center = [ "group:workspaces" ];
            end = [
              "group:deadlines"
              "group:status"
              "control-center"
            ];

            capsule_group = [
              {
                id = "workspaces";
                members = [
                  "workspaces"
                  "taskbar"
                ];
                accordion = true;
                accordion_direction = "end";
                padding = 6.0;
                widget_spacing = 10;
              }
              {
                id = "sysmon";
                members = [
                  "cpu"
                  "cpu-temp"
                  "ram"
                ];
                padding = 10.0;
                widget_spacing = 14;
              }
              {
                id = "deadlines";
                members = [
                  "grad-deadline"
                  "conf-deadline"
                ];
                padding = 10.0;
                widget_spacing = 16;
              }
              {
                id = "status";
                members = [
                  "caffeine"
                  "network"
                  "battery"
                ];
                padding = 10.0;
                widget_spacing = 12;
              }
            ];
          };

          widget = {
            clock = {
              format = "{:%a %d %b, %H:%M}";
              tooltip_format = "{:%H:%M %a, %b %d}";
            };

            # v4 SystemMonitor showed cpu usage, cpu temp and memory
            cpu = {
              type = "sysmon";
              stat = "cpu_usage";
              label_min_width = 30.0; # stop width jitter as values change
            };
            cpu-temp = {
              type = "sysmon";
              stat = "cpu_temp";
              label_min_width = 30.0; # stop width jitter as values change
            };
            ram = {
              type = "sysmon";
              stat = "ram_used";
              label_min_width = 30.0; # stop width jitter as values change
            };

            media = {
              artist_first = true;
              max_length = 145;
              title_scroll = "on_hover";
              hide_when_no_media = true;
            };

            workspaces = {
              scale = 1.3; # bigger workspace buttons
              style = "regular";
              label_source = "id";
              focused_color = "primary";
            };

            # revealed on hover over the workspaces: app icons grouped per workspace
            taskbar = {
              group_by_workspace = true;
              workspace_group_content = "icons";
              show_workspace_label = false; # numbers already shown by the workspaces widget
              hide_empty_workspaces = true;
              show_active_indicator = false; # dot overlapped the icon
              icon_scale = 1.1;
            };

            # v4 CustomButton textCommand -> local plugin in ./plugins/cmdtext
            grad-deadline = {
              type = "wignesh/cmdtext:cmd";
              command = "bash ${scripts}/grad.sh";
              glyph = "ghost";
            };
            conf-deadline = {
              type = "wignesh/cmdtext:cmd";
              command = "bash ${scripts}/conf.sh";
              glyph = "toilet-paper";
            };

            network.show_label = false; # v4 displayMode = "onhover"
            battery.display_mode = "graphic";
            control-center.glyph = "settings";
          };

          plugins = {
            enabled = [ "wignesh/cmdtext" ];
            auto_update = "official";
            source = [
              {
                name = "dotfiles";
                kind = "path";
                location = "${./plugins}";
                enabled = true;
              }
            ];
          };
        };
      };
    };
}

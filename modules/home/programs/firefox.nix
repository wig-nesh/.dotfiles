{ inputs, ... }:
{
  flake.homeModules.firefox =
    {
      pkgs,
      config,
      ...
    }:
    let
      firefoxAddonsPkgs = import inputs.nixpkgs {
        inherit (pkgs.stdenv.hostPlatform) system;
        config.allowUnfree = true;
        overlays = [
          inputs.firefox-addons.overlays.default
        ];
      };
    in
    {
      home.sessionVariables = {
        BROWSER = "firefox";
      };

      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
        profiles.default = {
          id = 0;
          name = "Default";

          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            # Enable HTTPS-Only Mode
            "dom.security.https_only_mode" = true;
            "dom.security.https_only_mode_ever_enabled" = true;

            # Privacy settings
            "privacy.donottrackheader.enabled" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
            "privacy.partition.network_state.ocsp_cache" = true;

            # Disable all sorts of telemetry
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "browser.ping-centre.telemetry" = false;
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.hybridContent.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.updatePing.enabled" = false;

            # As well as Firefox 'experiments'
            "experiments.activeExperiment" = false;
            "experiments.enabled" = false;
            "experiments.supported" = false;
            "network.allow-experiments" = false;

            # Disable Pocket Integration
            "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
            "extensions.pocket.enabled" = false;
            "extensions.pocket.api" = "";
            "extensions.pocket.oAuthConsumerKey" = "";
            "extensions.pocket.showHome" = false;
            "extensions.pocket.site" = "";

            # Restore previous session
            "browser.startup.page" = 3;
            # Vertical Tabs
            "sidebar.verticalTabs" = true;
            "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
            "sidebar.visibility" = "always-show";

            # Enable extensions by default
            "extensions.autoDisableScopes" = 0;

            # toolbar
            "browser.uiCustomization.state" =
              "{\"placements\":{\"widget-overflow-fixed-list\":[],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"vertical-spacer\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"downloads-button\",\"unified-extensions-button\",\"firefox-view-button\",\"alltabs-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[],\"vertical-tabs\":[\"tabbrowser-tabs\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"dirtyAreaCache\":[\"nav-bar\",\"PersonalToolbar\",\"unified-extensions-area\",\"toolbar-menubar\",\"TabsToolbar\",\"vertical-tabs\"],\"currentVersion\":23,\"newElementCount\":9}";

            # Home
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.topSitesRows" = 2;

            # Disable password saving prompts
            "signon.rememberSignons" = false;
            "signon.autofillForms" = false;
            "signon.generation.enabled" = false;
          };

          extensions = {
            force = true;
            packages = with firefoxAddonsPkgs.firefox-addons; [
              ublock-origin
              sponsorblock
              zotero-connector
              bitwarden
              improved-tube
              firefox-color
            ];
            settings = {
              "uBlock0@raymondhill.net".settings = {
                selectedFilterLists = [
                  "ublock-filters"
                  "ublock-badware"
                  "ublock-privacy"
                  "ublock-unbreak"
                  "ublock-quick-fixes"
                ];
              };

              "{3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf}".settings = {
                remove_home_page_shorts = true;
                theme = "black";
                ads = "block_all";
                hide_banner_ads = true;
                hide_sponsored_videos_home = true;
                mark_watched_videos = true;
                track_watched_videos = true;
                player_subtitles = "enabled";
                subtitles_language = "en";
                auto_generate = true;
              };
            };
          };

        };
        policies = {
          ExtensionSettings = {
            "uBlock0@raymondhill.net" = {
              default_area = "menupanel";
              private_browsing = true;
            };
            "sponsorBlocker@ajay.app" = {
              default_area = "menupanel";
            };
            "@testpilot-containers" = {
              default_area = "menupanel";
            };
            "zotero@chnm.gmu.edu" = {
              default_area = "navbar";
            };
            "{3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf}" = {
              default_area = "menupanel";
            };
            "FirefoxColor@mozilla.com" = {
              default_area = "menupanel";
            };
          };
        };
      };
    };
}

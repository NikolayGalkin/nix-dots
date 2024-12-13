{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.system.interface;
in
{
  options.${namespace}.system.interface = {
    enable = mkEnableOption "MacOS interface";
  };

  config = mkIf cfg.enable {
    system.defaults = {
      CustomSystemPreferences = {
        finder = {
          ShowExternalHardDrivesOnDesktop = false;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = false;
          ShowRemovableMediaOnDesktop = false;
          _FXSortFoldersFirst = true;
        };

        NSGlobalDomain = {
          # AppleAccentColor = 1;
          # AppleHighlightColor = "0.65098 0.85490 0.58431";
          # AppleSpacesSwitchOnActivate = false;
          WebKitDeveloperExtras = true;
        };
      };

      loginwindow = {
        # disable guest account
        GuestEnabled = false;
        # show name instead of username
        SHOWFULLNAME = false;
      };

      # file viewer settings
      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        # CreateDesktop = false;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = true;
        # NOTE: Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
        FXPreferredViewStyle = "clmv";
        QuitMenuItem = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
      };

      dock = {
        # auto show and hide dock
        autohide = true;
        # remove delay for showing dock
        autohide-delay = 0.0;
        # how fast is the dock showing animation
        autohide-time-modifier = 1.0;
        mineffect = "scale";
        minimize-to-application = true;
        mouse-over-hilite-stack = true;
        mru-spaces = false;
        orientation = "right";
        show-process-indicators = true;
        show-recents = false;
        showhidden = false;
        static-only = false;
        tilesize = 50;

        # Hot corners
        # Possible values:
        #  0: no-op
        #  2: Mission Control
        #  3: Show application windows
        #  4: Desktop
        #  5: Start screen saver
        #  6: Disable screen saver
        #  7: Dashboard
        # 10: Put display to sleep
        # 11: Launchpad
        # 12: Notification Center
        # 13: Lock Screen
        # 14: Quick Notes
        # wvous-tl-corner = 2;
        # wvous-tr-corner = 12;
        # wvous-bl-corner = 14;
        # wvous-br-corner = 4;

        persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/System/Applications/System Settings.app"
          "/System/Applications/Messages.app"
          "/System/Applications/Mail.app"
          "/System/Applications/Reminders.app"
          "/System/Applications/Notes.app"
          "/Applications/Safari.app"
          "${pkgs.wezterm}/Applications/WezTerm.app"
        ];
      };

      screencapture = {
        disable-shadow = false;
        location = "$HOME/Pictures/screenshots/";
        type = "png";
      };

      # spaces.spans-displays = !config.${namespace}.programs.graphical.apps.aerospace;

      menuExtraClock = {
        ShowDate = 1;
        Show24Hour = true;
        ShowDayOfMonth = true;
        ShowSeconds = true;
      };

      NSGlobalDomain = {
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.0;
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "WhenScrolling";
        NSAutomaticWindowAnimationsEnabled = false;
        _HIHideMenuBar = true;
      };
    };
  };
}

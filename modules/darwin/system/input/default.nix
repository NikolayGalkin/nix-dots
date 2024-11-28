{ config, lib, namespace, ... }:
let
  inherit (lib) mkIf mkMerge mkEnableOption;

  cfg = config.${namespace}.system.input;
in
{
  options.${namespace}.system.input = {
    enable = mkEnableOption "MacOS input";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      system = {
        keyboard = {
          enableKeyMapping = true;
          remapCapsLockToControl = true;
        };

        defaults = {
          trackpad = {
            Clicking = true;
            TrackpadRightClick = true; # enable two finger right click
            TrackpadThreeFingerDrag = true; # enable three finger drag
          };

          # ".GlobalPreferences" = {
          #   "com.apple.mouse.scaling" = 1.0;
          # };

          NSGlobalDomain = {
            AppleKeyboardUIMode = 3;
            ApplePressAndHoldEnabled = false;
            KeyRepeat = 2;
            InitialKeyRepeat = 10;

            # NSAutomaticCapitalizationEnabled = false;
            # NSAutomaticDashSubstitutionEnabled = false;
            # NSAutomaticQuoteSubstitutionEnabled = false;
            # NSAutomaticPeriodSubstitutionEnabled = false;
            # NSAutomaticSpellingCorrectionEnabled = false;
          };
        };
      };
    }
  ]);
}

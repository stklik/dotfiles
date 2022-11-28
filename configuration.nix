{ config, lib, inputs, pkgs, ... }:
{
  # imports = [ ~/.config/nixpkgs/darwin/local-configuration.nix ];

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    # Read the configuration from the Brewfile!
    extraConfig = (builtins.readFile ./Brewfile);
  };

  networking = {
    # computerName = "Eos";
    # hostName = "Eos";
  }; 

  security.pam.enableSudoTouchIdAuth = true;

  # system.patches = [ ./pam.patch ];

  services.nix-daemon.enable = true;

# Temporary disabled:

  # Set highlight color to green
  # defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"


  # Set Help Viewer windows to non-floating mode
  # defaults write com.apple.helpviewer DevMode -bool true


# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
# sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName


# Disable Notification Center and remove the menu bar icon
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null



system = {
    defaults = {

        CustomSystemPreferences = {
            # Require password immediately after sleep or screen saver begins
            "com.apple.screensaver" = {
                askForPassword = true;
                askForPasswordDelay = 0;
            };

            # Hide Siri menu bar icon
            "com.apple.Siri" = {
                StatusMenuVisible = false;
            };

            # Automatically quit printer app once the print jobs complete
            "com.apple.print.PrintingPrefs" = {
                "Quit When Finished" = true;
            };

            # Set language and text formats
            # Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
            # `Inches`, `en_GB` with `en_US`, and `true` with `false`.
            NSGlobalDomain = {
                # AppleLanguages = ["en" "de"];
                AppleLocale = "en_GB@currency=EUR";
                AppleMeasurementUnits = "Centimeters";
                AppleMetricUnits = true;
            };


            "com.apple.BluetoothAudioAgent" = {
                "Apple Bitpool Min (editable)" = 40;
            };

            "com.apple.finder" = {
                # Set Homefolder as the default location for new Finder windows 
                # For other paths, use `PfLo` and `file:///full/path/here/`
                NewWindowTarget = "PfHm";
                NewWindowTargetPath = "file://''$''{HOME''}";

                # Show icons for hard drives, servers, and removable media on the desktop
                ShowExternalHardDrivesOnDesktop = true;
                ShowHardDrivesOnDesktop = true;
                ShowMountedServersOnDesktop = true;
                ShowRemovableMediaOnDesktop = true;

                # Automatically open a new Finder window when a volume is mounted
                OpenWindowForNewRemovableDisk = true;
            };


            # Avoid creating .DS_Store files on network or USB volumes
            "com.apple.desktopservices" = {
                DSDontWriteNetworkStores = true;
                DSDontWriteUSBStores = true;
            };



            # Disable disk image verification
            "com.apple.frameworks.diskimages" = {
                skip-verify = true;
                skip-verify-locked = true;
                skip-verify-remote = true;

                # Automatically open a new Finder window when a volume is mounted
                auto-open-ro-root = true;
                auto-open-rw-root = true;
            };

            "com.apple.dock" = {
                # Lock the Dock size
                size-immutable = true;

                # resize magnification
                magnification = true;

                # Icon size of magnified Dock items 
                largesize = 50;
            };

            ###############################################################################
            #  Mac App Store                                                               #
            ###############################################################################
 
            "com.apple.appstore" = {
                # Enable the WebKit Developer Tools in the Mac App Store
                WebKitDeveloperExtras = true;

                # Enable Debug Menu in the Mac App Store
                ShowDebugMenu = true;
            };

            "com.apple.SoftwareUpdate" = {
                # Enable the automatic update check
                AutomaticCheckEnabled = true;

                # Check for software updates daily, not just once per week
                ScheduleFrequency = 1;

                # Download newly available updates in background
                AutomaticDownload = 1;

                # Install System data files & security updates
                CriticalUpdateInstall = 1;

                # Automatically download apps purchased on other Macs
                ConfigDataInstall = 1;
            };

            # Turn on app auto-update
            "com.apple.commerce".AutoUpdate = true;

            # Prevent Photos from opening automatically when devices are plugged in
            "com.apple.ImageCapture".disableHotPlug = true;

            # Use plain text mode for new TextEdit documents
            "com.apple.TextEdit" = {
                RichText = 0;

                # Open and save files as UTF-8 in TextEdit
                PlainTextEncoding = 4;
                PlainTextEncodingForWrite = 4;
            };

            # Prevent Time Machine from prompting to use new hard drives as backup volume
            "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;


            ###############################################################################
            # Google Chrome & Google Chrome Canary                                        #
            ###############################################################################

            "com.google.Chrome" = {
                # Disable the all too sensitive backswipe on trackpads
                # AppleEnableSwipeNavigateWithScrolls = false;

                # Disable the all too sensitive backswipe on Magic Mouse
                # AppleEnableMouseSwipeNavigateWithScrolls = false;

                # Use the system-native print preview dialog
                DisablePrintPreview = true;

                # Expand the print dialog by default
                PMPrintingExpandedStateForPrint2 = true;
            };

            ###############################################################################
            # Terminal & iTerm 2                                                          #
            ###############################################################################

            "com.apple.terminal" = {
                # Only use UTF-8 in Terminal.app
                StringEncodings = 4;

                # Enable “focus follows mouse” for Terminal.app and all X11 apps
                # i.e. hover over a window and start typing in it without clicking first
                FocusFollowsMouse = true;
                #defaults write org.x.X11 wm_ffm = true;

                # Enable Secure Keyboard Entry in Terminal.app
                # See: https://security.stackexchange.com/a/47786/8918
                SecureKeyboardEntry = true;
            };

            "com.googlecode.iterm2" = {
                # Don’t display the annoying prompt when quitting iTerm
                PromptOnQuit = false;

                # set system-wide hotkey to show/hide iterm with ^\`
                Hotkey = true;

                # defaults write com.googlecode.iterm2 HotkeyChar -int 96;
                # defaults write com.googlecode.iterm2 HotkeyCode -int 50;
                FocusFollowsMouse = 1;

                # Three-finger tap emulates middle click? Takes a boolean.
                ThreeFingerEmulates = true;

                # Double-click performs smart selection
                DoubleClickPerformsSmartSelection = true;
            };
        };


        # Disable transparency in the menu bar and elsewhere on Yosemite
        # universalaccess.reduceTransparency = true;

        # Disable the “Are you sure you want to open this application?” dialog
        LaunchServices.LSQuarantine = false;

        NSGlobalDomain = {


            # Set to 'Dark' to enable dark mode, or leave unset for normal mode.
            # AppleInterfaceStyle = "Dark";

            # Whether to automatically switch between light and dark mode. The default is false.
            AppleInterfaceStyleSwitchesAutomatically = true;

            # Set sidebar icon size to medium
            NSTableViewDefaultSizeMode = 2;

            # When to show scrollbars
            # Possible values: `WhenScrolling`, `Automatic` and `Always`
            AppleShowScrollBars = "Automatic";

            # Disable the over-the-top focus ring animation
            NSUseAnimatedFocusRing = false;

            # Increase window resize speed for Cocoa applications
            NSWindowResizeTime = 0.001;

            # Expand save panel by default
            NSNavPanelExpandedStateForSaveMode = true;
            NSNavPanelExpandedStateForSaveMode2 = true;

            # Expand print panel by default
            PMPrintingExpandedStateForPrint = true;
            PMPrintingExpandedStateForPrint2 = true;

            # Save to disk (not to iCloud) by default
            NSDocumentSaveNewDocumentsToCloud = false;

            # Display ASCII control characters using caret notation in standard text views
            # Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
            NSTextShowsControlCharacters = true;

            # Disable automatic capitalization as it’s annoying when typing code
            NSAutomaticCapitalizationEnabled = false;

            # Disable smart dashes as they’re annoying when typing code
            NSAutomaticDashSubstitutionEnabled = false;

            # Disable automatic period substitution as it’s annoying when typing code
            NSAutomaticPeriodSubstitutionEnabled = false;

            # Disable smart quotes as they’re annoying when typing code
            NSAutomaticQuoteSubstitutionEnabled = false;

            # Disable auto-correct
            NSAutomaticSpellingCorrectionEnabled = false;

            # Trackpad: enable tap to click for this user and for the login screen
            # com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
            # defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
            "com.apple.mouse.tapBehavior" = 1;

            # Disable “natural” (Lion-style) scrolling
            "com.apple.swipescrolldirection" = false;

            # Enable full keyboard access for all controls
            # (e.g. enable Tab in modal dialogs)
            AppleKeyboardUIMode = 3;

            # Disable press-and-hold for keys in favor of key repeat
            # ApplePressAndHoldEnabled -bool false

            # Set a blazingly fast keyboard repeat rate
            InitialKeyRepeat = 20;
            KeyRepeat = 2;

            # Sets the level of font smoothing (sub-pixel font rendering).
            AppleFontSmoothing = 1;

            # AppleTemperatureUnit
            AppleTemperatureUnit = "Celsius";

            # Enable spring loading for directories
            "com.apple.springing.enabled" = true;

            # Set the spring loading delay for directories (in seconds)
            "com.apple.springing.delay" = 0.1;


            "com.apple.trackpad.scaling" = 1.5;


            _HIHideMenuBar = false;
        };

        # Use scroll gesture with the Ctrl (^) modifier key to zoom
        universalaccess.closeViewScrollWheelToggle = true;
        # sudo defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

        # Follow the keyboard focus while zoomed in
        # universalaccess.closeViewZoomFollowsFocus = true;

        # Save screenshots to Downloads
        screencapture.location = "''$''{HOME''}/Downloads";
        screencapture.type = "png";
        screencapture.disable-shadow = true;

        # - - - - - -
        #  Dock
        # - - - - - -
        dock = {
            # place Dock on left
            orientation = "left";

            # Set the icon size of Dock items to N pixels
            tilesize = 20;

            # Change minimize/maximize window effect
            # Minimization effect: 'genie', 'scale', 'suck'
            mineffect = "scale";

            # Disable highlight hover effect for the grid view of a stack (Dock)
            mouse-over-hilite-stack = false;

            # Minimize windows into their application’s icon
            minimize-to-application = false;

            # Enable spring loading for all Dock items
            enable-spring-load-actions-on-all-items = true;

            # Show indicator lights for open applications in the Dock
            show-process-indicators = true;

            # Show only open applications in the Dock
            static-only = false;

            # Animate opening applications from the Dock. The default is true.
            launchanim = true;

            # Don’t show Dashboard as a Space
            dashboard-in-overlay = true;

            # Don’t automatically rearrange Spaces based on most recent use
            mru-spaces = false;

            # Don't Automatically hide and show the Dock
            autohide = false;

            # Make Dock icons of hidden applications translucent
            showhidden = true;

            # Don’t show recent applications in Dock
            show-recents = false;

            # Whether to display the appswitcher on all displays or only the main one. The default is false.
            appswitcher-all-displays = true;

            # Hot corners 
            wvous-bl-corner = 10;

        };

        # - - - - - -
        #   Finder 
        # - - - - - -
        finder = {

            # Finder: show hidden files by default
            AppleShowAllFiles = true;

            # Finder: show all filename extensions
            AppleShowAllExtensions = true;

            # Finder: show status bar
            ShowStatusBar = true;

            # Finder: show path bar
            ShowPathbar = true;

            # Display full POSIX path as Finder window title
            _FXShowPosixPathInTitle = true;

            # Keep folders on top when sorting by name
            # _FXSortFoldersFirst = true;

            # When performing a search, search the current folder by default
            FXDefaultSearchScope = "SCcf";

            # Disable the warning when changing a file extension
            FXEnableExtensionChangeWarning = false;

            # Use list view in all Finder windows by default
            # Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
            FXPreferredViewStyle = "Nlsv";



# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
#defaults write com.apple.finder FXInfoPanesExpanded -dict \
# General -bool true \
# OpenWith -bool true \
# Privileges -bool true


        };


        # - - - - - -
        #  ActivityMonitor 
        # - - - - - -

        ActivityMonitor = {
            # Visualize CPU usage in the Activity Monitor Dock icon
            IconType = 5;

            # Show the main window when launching Activity Monitor
            OpenMainWindow = true;

            # Show all processes in Activity Monitor
            ShowCategory = 100;

            # Sort Activity Monitor results by CPU usage
            SortColumn = "CPUUsage";
            SortDirection = 0;

            # Show Data in the Disk graph (instead of IO)  # TODO
            # defaults write com.apple.ActivityMonitor DiskGraphType -int 1

            # Show Data in the Network graph (instead of packets)  # TODO
            # defaults write com.apple.ActivityMonitor NetworkGraphType -int 1
        };


        trackpad.Clicking = true;
        trackpad.TrackpadThreeFingerDrag = true;

        magicmouse.MouseButtonMode = "TwoButton";
    };

    keyboard = {
        enableKeyMapping = true;
        remapCapsLockToEscape = true;
    };

  };

  # system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  # system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  # system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  # system.defaults.NSGlobalDomain.KeyRepeat = 1;
  # system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  # system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  # system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  # system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  # system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  # system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  # system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
  # system.defaults.NSGlobalDomain._HIHideMenuBar = true;

  # system.defaults.dock.autohide = true;
  # system.defaults.dock.mru-spaces = false;
  # system.defaults.dock.orientation = "left";
  # system.defaults.dock.showhidden = true;

  # system.defaults.finder.AppleShowAllExtensions = true;
  # system.defaults.finder.QuitMenuItem = true;
  # system.defaults.finder.FXEnableExtensionChangeWarning = false;

  # system.defaults.trackpad.Clicking = true;
  # system.defaults.trackpad.TrackpadThreeFingerDrag = true;

}

#. Copy+paste::

     defaults write org.macosforge.xquartz.X11 wm_ffm -bool true
     defaults write org.x.X11 wm_ffm -bool true
     defaults write com.apple.Terminal FocusFollowsMouse -string YES

   **Purpose:** This sets the policy where "focus follows mouse" for
   relevant applications. After this, clicks on a new window are
   directly applied, without needing to "pre-click" it.  You're
   welcome.

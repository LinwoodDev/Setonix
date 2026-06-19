# Changelog

<!--ENTER CHANGELOG HERE-->

## 0.8.0 (2026-06-15)

* Redesign home page to be more user friendly and simplify navigating through the views
* Add state restoration to allow resuming games after app restarts
* Add game mode groups in play dialog
* Add world close event to allow cleaning up resources when a game is closed
* Add save event to allow scripts to save game data when the game is saved
* Add server thumbnails to public and in-app server lists
* Add optional server list thumbnail overrides
* Add bundled server list thumbnail asset path
* Improve game page title to show the opened game
* Improve Luau script error messages with game mode and script context
* Improve app and server security checks
* Swap custom and template tabs in create dialog
* Harden multiplayer authentication and imported file names
* Prevent creating games without a name
* Fix loading the Blackjack game mode
* Fix Chess and Blackjack names in singleplayer game mode groups
* Fix Blackjack actions and card visibility
* Fix playing a game without a selection showing a missing route
* Fix overlapping tooltips in stacked hand view layouts
* Fix stopping the server from the command prompt throwing an exception
* Migrate the native plugin build from cargokit to Flutter native assets
* Upgrade to flutter 3.44

Read more here: https://linwood.dev/setonix/0.8.0

## 0.7.1 (2026-05-11)

* Improve user interface on home page
* Fix app not launching on ios, macos, android and web

Read more here: https://linwood.dev/setonix/0.7.1

## 0.7.0 (2026-04-29)

* Add zoom gestures
* Add create from template
* Add high level scripting API for packs
* Add support for game modes and scripts in single-player
* Add game mode and scripts to editor
* Add localized names and descriptions for game modes
* Improve hand view UI animations and responsiveness
* Improve mouse and long-press input feedback for hand items
* Fix dragging on the hand view also moving the game world
* Fix jittering when dragging items from hand
* Fix spawning objects overwriting existing ones in a cell
* Fix server state dropping hidden card variations before script evaluation
* Fix server builds not created for released versions
* Improve server docs by ignoring generated files
* Improve hand view background design
* Improve hand item name visibility with a pill background
* Upgrade to flutter 3.41

Read more here: https://linwood.dev/setonix/0.7.0

## 0.6.0 (2026-01-28)

* Add lua scripting support to server
  * Add game modes to packs
  * Add scripts directory
  * Add blackjack sample game mode
* Add waypoints
* Add action buttons support
* Add toolbar options
* Add welcome text to server
* Add checkbox and dropdown dialog components
* Improve message author display
* Fix home page header text color in certain themes
* Fix released server archives have no core pack
* Fix design name
* Fix kick command usage
* Fix cards stretches if texture is not rectangular
* Fix kick message
* Fix user system on server
* Rebuild event system
* Add legacy android build
* Modernize project structure
* Upgrade to flutter 3.38

Read more here: https://linwood.dev/setonix/0.6.0

## 0.5.2 (2025-09-30)

* Add snap support
* Rename single player and multiplayer dialog
* Remove browse tab
* Improve textures of spades in cards and add better resolution to the card background, chips and dice
* Improve display of identifier of installed packs in dialog
* Swap board and figures in hand view
* Redesign chess figures
* Use minSdkVersion 24 instead of 23 (The minimum version of android is 7.0 (Nougat))
* Upgrade to flutter 3.35

Read more here: https://linwood.dev/setonix/0.5.2

## 0.5.1 (2025-07-22)

* Redesign cards to have higher resolution
* Redesign home page
* Upgrade to agb 8.11
* Allow referencing user with name and fingerprint
* Fix serverlist route
* Add support for arm AppImage builds

Read more here: https://linwood.dev/setonix/0.5.1

## 0.5.0 (2025-07-02)

* Add account system
* Add auth system
* Add loading screen
* Add server list
* Add kick message
* Add user system on server
  * Local database
  * Remote endpoint
* Add whitelist system on server
* Fix sensitivity setting not visible on web
* Fix editor not working on web

Read more here: https://linwood.dev/setonix/0.5.0

## 0.4.1 (2025-06-09)

* Improve parsing of server url
* Improve rendering of cards
  * Make bottom panel smaller
  * Fix items overflowing with size
* Add config system for server
* Add error handling for invalid packs
* Fix dragging cards on mobile
* Fix world not loading in multiplayer
* Fix team creation not working
* Fix team changes not being synced correctly in multiplayer
* Add support for defining host for server
* Fix core pack not included in build
* Fix server crash when invalid request is made

Read more here: https://linwood.dev/setonix/0.4.1

## 0.4.0 (2025-06-05)

* Add importing system for editor
* Add launch app link for android ([#37](https://github.com/LinwoodDev/Setonix/issues/37))
* Add option for server to send link information
* Add import and export settings
* Add density settings
* Add arrow key hand keyboard navigation
* Improve multiplayer ui
* Improve card rendering layout
* Add swamp multiplayer support
* Add scroll sensitivity setting
* Add remaining empty indicator to editor tabs
* Fix renaming teams not working ([#48](https://github.com/LinwoodDev/Setonix/issues/48))
* Fix edit mode tooltip
* Migrate away from flutter_markdown
* Upgrade to flutter 3.32
* Update to agb 8.9

Read more here: https://linwood.dev/setonix/0.4.0

## 0.3.0 (2025-01-27)

* Add editor
* Fix importing of packs
* Fix packs not available on singleplayer
* Rework packs dialog
* Upgrade to flutter 3.27
* Use minSdkVersion 23 instead of 21 (The minimum version of android is 6.0 (Marshmallow))
* Upgrade to agb 8.8
* Fix reproducable builds again
* Add linux arm

Read more here: https://linwood.dev/setonix/0.3.0

## 0.2.0 (2024-11-25)

* Add protection to cells if they are hidden
* Add download for packs ([#39](https://github.com/LinwoodDev/Setonix/issues/39))
* Add data metadata for packs
* Use hash of archive for signature
* Add dialog image support ([#40](https://github.com/LinwoodDev/Setonix/issues/40))
* Fix multiple settings button on home page
* Disable packs item if client is not a server
* Use bolder monochrome icon for android
* Make build reproducable

Read more here: https://linwood.dev/setonix/0.2.0

## 0.1.1 (2024-10-21)

* Add internet permission to android
* Fix app crashing if socket cannot be created

## 0.1.0 (2024-10-21)

First release 🎉

# Trolls
A Godot based platformer where you will kill enemies to advance to the next level. Along the way collect keys, fireballs, extra life, and coins. Open mystery boxes for more items. Climb ladders and teleport to unknown locations using portal doors. Flip switches and use keys to open doors to other areas. Some blocks can be broken, clearing the path ahead. Jump on spring pads to reach high platforms. Finally, avoid the hazards along the way.

Runs on MacOS, Linux, Windows, and iOS

![Level 1 Screenhot](/screenshot.png)

## Design Considerations
### Level Limits

1. No limit on enemies
2. No limit on coins
3. No limit on switched doors
4. No limit on portal doors
5. No limit on springs
6. No limit on breakable tiles
7. No limit on mystery boxes
8. No limit on hearts
9. No limit on fireballs
10. Maximum of three keys
11. Maximum of three locked doors w/ rooms
12. One Ogre as a boss that must be killed to advance to the next level

### Room Limits
1. No limit on enemies
2. No limit on coins
3. No limit on switched doors
4. No limit on portal doors
5. No limit on springs
6. No limit on breakable tiles
8. No limit on mystery boxes
9. No limt on hearts
10. No limit on fireballs
11. Maximum of one key
12. No locked doors in rooms

### Items of Note
1. Remember that running the scene directly messes up screen transitions. No previous scene to remove
2. Make.sure that enemies are assigned to the “enemies ” group
3. When instantiating a new enemy, trap, etc. make sure collision layers and masks are set correctly

## Config File Locations
Config files can be found here:

	Windows: %APPDATA%\Godot\app_userdata\Trolls  
	macOS: ~/Library/Application Support/Godot/app_userdata/Trolls  
	Linux: ~/.local/share/godot/app_userdata/Trolls

## Export Notes
1. Set version number in localization file
2. Set version number in export templates
3. Set const GOD_MODE = false in Globals.gd
4. Comment out any screen size settings in Startup.gd _ready() function
5. Set design_mode = false in the node inspector for all levels and rooms
6. Check project settings Rendering -> Renderer -> Rendering Method.mobile is set to "mobile"
7. Export without debug information
8. Sign macOS and Windows executables

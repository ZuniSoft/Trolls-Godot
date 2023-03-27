# Trolls
Godot based platformer game where you will kill enemies to advance to the next level. Along the way collect keys, fireballs, extra life, and coins. Open mystery boxes for more items. Climb ladders and teleport to unknown locations using portal doors. Flip switches and use keys to open doors to other areas. Finally avoid the hazards along the way.

![Level 1 Screenhot](/screenshot.png)

## Design Considerations
### Level Limits

1. No limit on enemies
2. No limit on coins
3. No limit on switched doors
4. No limit on portal doors
5. Maximum of three locked doors w/ rooms
6. Maximum of three keys
7. Maximum of five mystery boxes
8. Maximum of three hearts
9. Maximum of three fireballs
10. One Ogre as a boss that must be killed to advance to the next level

### Room Limits
1. No limit on enemies
2. No limit on coins
3. No limit on switched doors
4. No limit on portal doors
5. No locked doors w/ rooms
6. Maximum of one key
7. Maximum of five mystery boxes
8. Maximum of one heart
9. Maximum of one fireball

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
3. Export without debug information
4. Sign macOS and Windows executables
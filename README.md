# Trolls
Godot based platformer game where you will kill enemies to advance to the next level. Along the way collect keys, fireballs, extra life, and coins. Open mystery boxes for more items. Climb ladders and teleport to unknown locations using portal doors. Flip switches and use keys to open doors to other areas. Finally avoid the hazards along the way.

![Level 1 Screenhot](/screenshot.png)

## Level Design Considerations
#### Limits

1. No limit on enemies
2. No limit on coins
3. No limit on switched doors
4. No limit on portal doors
5. Maximum of three locked doors w/ sub-levels
6. Maximum of three keys
7. Maximum of five mystery boxes
8. Maximum of three hearts
9. Maximum of three fireballs
10. Sub-levels have no locked doors
11. One Ogre as a boss that must be killed to advance to the next level


#### Items of Note
1. Remember that running the scene directly messes up screen transitions. No previous scene to remove.
2. Make.sure that enemies are assigned to the “enemies ” group.
3. When instantiating a new enemy, trap, etc. make sure collision layers and masks are set correctly.
## Config File Locations

Config files can be found here:

	Windows: %APPDATA%\Godot\app_userdata\Trolls  
	macOS: ~/Library/Application Support/Godot/app_userdata/Trolls  
	Linux: ~/.local/share/godot/app_userdata/Trolls

## Godot Export Notes

1. For notarization, create an app specific password on appleid.apple.com for Godot.
2. Go to Xcode Settings, Accounts and create a Developer ID Application certificate.
3. Run `security find-identity -v -p codesigning` to find the long string of the Developer ID Application certificate, that should be the Identity for Codesign in the Godot export template settings. Use &lt;long-C&gt; from below.

 	```
	<long-A> "Apple Development: Your Name (<short-1>)"   
 	<long-B> "Apple Distribution: Your Name (<short-2>)"  
 	<long-C> "Developer ID Application: Your Name (<short-2>)"  
 	3 valid identities found
4. For notarytool create a credential in your keychain using “DMG Notarization” as the name and the app specific password by following the prompts after running:
 	`xcrun notarytool store-credentials --apple-id "keithrdavis.krd@gmail.com" --team-id "S63L4926ND"`  
5. Windows .exe needs to have icon replaced.
6. Remember to export without Debug on the export file dialog.


# Trolls
Godot based platformer game where you will kill enemies to adavnce to the next level. Along the way collect keys, fireballs, extra life, and coins. Open mystery boxes for more items. Climb ladders and teleport to unknown locations using portal doors. Flip switches and use keys to open doors to other areas. Finally avoid the hazards along the way.

![Level 1 Screenhot](/screenshot.png)

## Level Design Considerations

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

## Config File Locations

Config files can be found here:

	Windows: %APPDATA%\Godot\app_userdata\Trolls  
	macOS: ~/Library/Application Support/Godot/app_userdata/Trolls  
	Linux: ~/.local/share/godot/app_userdata/Trolls

## Godot Export Notes

1. For notarization, create an app specific password on appleid.apple.com for Godot.
2. Go to Xcode Settings, Accounts and create a Developer ID Application certificate.
3. Use “security find-identity -v -p codesigning” to find the long string of the Developer ID Application certificate, that should be the Identity for Codesign in the Godot export template settings.

	&lt;long-A&gt; "Apple Development: Your Name (&lt;short-1&gt;)"   
	&lt;long-B&gt; "Apple Distribution: Your Name (&lt;short-2&gt;)"  
	&lt;long-C&gt; "Developer ID Application: Your Name (&lt;short-2&gt;)"  
	3 valid identities found 
	
	Use &lt;long-C&gt; from above.
4. Enable export settings:

	\[preset.0\]

	name="Mac OSX"  
	platform="Mac OSX"  
	runnable=true  
	custom_features=""  
	export_filter="all_resources"  
	include_filter=""  
	exclude_filter=""  
	export_path="./Trolls.dmg"  
	script_export_mode=1  
	script_encryption_key=""  

	\[preset.0.options\]

	custom_template/debug=""  
	custom_template/release=""  
	application/name="Trolls"  
	application/info="Made with Godot Engine"  
	application/icon="res://icon.png"  
	application/identifier="com.zunisoft.macos.trolls"  
	application/signature=""  
	application/app_category="Games"  
	application/short_version="1.0"  
	application/version="50"  
	application/copyright="Copyright © 2023 Zunisoft All rights reserved."  
	display/high_res=true  
	privacy/microphone_usage_description=""  
	privacy/camera_usage_description=""  
	privacy/location_usage_description=""  
	privacy/address_book_usage_description=""  
	privacy/calendar_usage_description=""  
	privacy/photos_library_usage_description=""  
	privacy/desktop_folder_usage_description=""  
	privacy/documents_folder_usage_description=""  
	privacy/downloads_folder_usage_description=""  
	privacy/network_volumes_usage_description=""  
	privacy/removable_volumes_usage_description=""  
	codesign/enable=true  
	codesign/identity=&lt;long-c&gt;  
	codesign/timestamp=true  
	codesign/hardened_runtime=true  
	codesign/replace_existing_signature=true  
	codesign/entitlements/custom_file=""  
	codesign/entitlements/allow_jit_code_execution=false  
	codesign/entitlements/allow_unsigned_executable_memory=false  
	codesign/entitlements/allow_dyld_environment_variables=false  
	codesign/entitlements/disable_library_validation=false  
	codesign/entitlements/audio_input=false  
	codesign/entitlements/camera=false  
	coding/entitlements/location=false  
	codesign/entitlements/address_book=false  
	codesign/entitlements/calendars=false  
	codesign/entitlements/photos_library=false  
	codesign/entitlements/apple_events=false  
	codesign/entitlements/debugging=false  
	codesign/entitlements/app_sandbox/enabled=true  
	codesign/entitlements/app_sandbox/network_server=false  
	codesign/entitlements/app_sandbox/network_client=false  
	codesign/entitlements/app_sandbox/device_usb=false  
	codesign/entitlements/app_sandbox/device_bluetooth=false  
	codesign/entitlements/app_sandbox/files_downloads=0  
	codesign/entitlements/app_sandbox/files_pictures=0  
	codesign/entitlements/app_sandbox/files_music=0  
	codesign/entitlements/app_sandbox/files_movies=0  
	codesign/custom_options=PoolStringArray(  )  
	notarization/enable=true  
	notarization/apple_id_name="keithrdavis.krd@gmail.com"  
	notarization/apple_id_password=&lt;app-specific-password&gt;  
	notarization/apple_team_id=""  
	texture_format/s3tc=true  
	texture_format/etc=false  
	texture_format/etc2=false

5. After the signing and notarization process has completed (e-mail notification), run “stapler staple ./Trolls.dmg”.
6. Remember to export without Debug on the export file dialog.


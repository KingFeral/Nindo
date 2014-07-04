

#define BUILD_VERSION "v0.01a"

world
	view		= "32x24"
	mob			= /login
	fps			= 40
	version		= 0
	map_format	= TOPDOWN_MAP

	New()
		var/ini_reader/ini_reader = new("config.ini", INIREADER_INI)
		var/list/config = ini_reader.ReadSetting("settings")
		if(!config || !config.len)
			world.log << "Error: Missing configuration file."
			world.Del()
			return 0

		src.name         = "[config["name"]] ([BUILD_VERSION])"
		src.hub          = config["hub"]
		src.hub_password = config["hub_password"]

		. = ..()

		load_villages()

	Del()
		. = ..()
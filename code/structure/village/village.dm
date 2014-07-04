

var/global/list/villages

proc/load_villages()
	var/timestamp = world.timeofday

	global.villages = new()
	global.villages["leaf"] = new/village("Leaf", null)
	global.villages["mist"] = new/village("Mist", null)
	global.villages["sand"] = new/village("Sand", null)
	global.villages["none"] = new/village("None", null)

	var/elapsed_time = (world.timeofday - timestamp) / 10

	world.log << "Villages loaded in [elapsed_time] seconds."

character
	var/tmp/village/village

village
	parent_type = /structure

	var/tmp/list/factions

	New(name, leader)
		..()
		src.factions = new()

		var/faction/main_faction = new(src.name, null)

		main_faction.village = src

		src.factions += main_faction

	join(character/user)
		user.village = src
		user.refresh_mouse_icon()

		src.online_members += user

	leave(character/user)
		src.online_members -= user

		var/village/none = global.villages["none"]
		none.join(user)
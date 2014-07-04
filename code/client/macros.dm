

//note, should be a global object...

var/global/list/key_name2key = list(
	"key_north" 			= KEY_NORTH,
	"key_south" 			= KEY_SOUTH,
	"key_east" 				= KEY_EAST,
	"key_west" 				= KEY_WEST,
	"key_attack"			= KEY_ATTACK,
	"key_defend"			= KEY_DEFEND,
	)

client
	var/tmp/macro_controller/macro_controller

	verb/key_down(key as text)
		set/hidden = 1
		set/instant = 1

		if((key in MOVEMENT_KEYS) && !src.can_move())
			return 0

		src.gamepad.key_down(global.key_name2key[key])

	verb/key_up(key as text)
		set/hidden = 1
		set/instant = 1

		src.gamepad.key_up(global.key_name2key[key])

macro_controller
	var/tmp/client/client
	var/tmp/list/macros = list()

	New(var/client/client)
		if(client)
			src.set_client(client)
			src.initialize()

	proc/set_client(var/client/client)
		src.client = client

	proc/initialize()
		//movement.
		src.create_macro("macro", "key_north", "W")
		src.create_macro("macro", "key_south", "S")
		src.create_macro("macro", "key_east",  "D")
		src.create_macro("macro", "key_west",  "A")

		//inventory-related keys.
		src.create_macro("macro", "key_use_item", "Return")
		src.create_macro("macro", "key_quickswap_up", "North")
		src.create_macro("macro", "key_quickswap_down", "South")
		src.create_macro("macro", "key_quickswap_right", "East")
		src.create_macro("macro", "key_quickswap_left", "West")

		//combat keys.
		src.create_macro("macro", "key_attack", "F")
		src.create_macro("macro", "key_defend", "E")

	proc/create_macro(var/namespace, var/key_name, var/key, var/params)
		winset(client, "[key_name]Dn", "parent=[namespace];name=[key];command=\"key-down [key_name]\";[params]")
		winset(client, "[key_name]Up", "parent=[namespace];name=[key]+UP;command=\"key-up [key_name]\";[params]")
		//var/list/results = winget(src.client, "macro.*", "id")
		//for(var/result in params2list(results))
		//	world.log << result

	proc/delete_macro(var/namespace, var/key_name)
		winset(src.client, "[namespace].[key_name]Up", "parent=")
		winset(src.client, "[namespace].[key_name]Dn", "parent=")
		//var/list/results = winget(src.client, "macro.*", "id")
		//for(var/result in params2list(results))
		//	world.log << result
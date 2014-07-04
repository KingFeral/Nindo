	/*

var/global/KEY_LIFE							= 1.5
var/global/KEY_NORTH						= 1
var/global/KEY_SOUTH						= 2
var/global/KEY_EAST							= 3
var/global/KEY_WEST							= 4
var/global/KEY_ATTACK						= 5
var/global/KEY_DEFEND						= 6*/

client
	var/tmp/gamepad/gamepad

gamepad
	var/tmp/client/client
	var/tmp/last_pressed_key

	var/tmp/list/active_inputs = list()

	var/tmp/list/keys = list(
		list(),
		list(),
		list(),
		list(),
		list(),
		list(),
		)

	var/tmp/list/key_events = list(
		list(),
		list(),
		list(),
		list(),
		list(),
		list(),
		)

	New(var/client/client)
		if(client)
			src.client = client
			src.initialize()

	proc/initialize()
		src.register_key_event(global.key_events[KEY_NORTH], KEY_NORTH)
		src.register_key_event(global.key_events[KEY_SOUTH], KEY_SOUTH)
		src.register_key_event(global.key_events[KEY_EAST], KEY_EAST)
		src.register_key_event(global.key_events[KEY_WEST], KEY_WEST)
		src.register_key_event(global.key_events[KEY_ATTACK], KEY_ATTACK)
		src.register_key_event(global.key_events[KEY_DEFEND], KEY_DEFEND)

	proc/register_key_event(var/datum/key_action, var/key)
		src.key_events[key] += key_action

	proc/key_down(var/key)
		src.keys[key]["state"] = 1
		src.keys[key]["pressed"] = world.time
		src.active_inputs += key

		if(src.last_pressed_key && src.last_pressed_key == key && world.time - src.keys[last_pressed_key]["released"] < KEY_LIFE)
			src.keys[key]["taps"] += 1
		else
			src.keys[key]["taps"] = 1

		src.last_pressed_key = key

		for(var/datum/d in src.key_events[key])
			if(hascall(d, "on_key_press"))
				call(d, "on_key_press")(src.client, key)

	proc/key_up(var/key)
		src.keys[key]["state"] = 0
		src.keys[key]["released"] = world.time
		src.keys[key]["duration"] = world.time - src.keys[key]["pressed"]
		src.active_inputs -= key

		for(var/datum/d in src.key_events[key])
			if(hascall(d, "on_key_release"))
				call(d, "on_key_release")(src.client, key)

//key events...

//moving back to gamepad lists...

//our key object...
//these are responsible for calling key_events
/*
key
	var/id
	var/name
	var/tmp/dir
	var/tmp/state = 0
	var/tmp/taps = 1
	var/tmp/maximum_taps //define to set a maximum.
	var/tmp/duration = 0
	var/tmp/list/timestamps = list()
	var/tmp/list/key_events = list()

	New(id, name, maximum_taps)
		src.id = id
		src.name = name
		if(maximum_taps)
			src.maximum_taps = maximum_taps

	proc/register_key_event(var/datum/key_action)
		src.key_events += key_action

	proc/remove_key_event(var/datum/key_action)
		src.key_events -= key_action

	proc/key_down(var/client/client)
		src.state = 1
		src.timestamps["pressed"] = world.time

		var/gamepad/gamepad = client.gamepad
		var/key/last_pressed_key = gamepad.last_pressed_key

		if(last_pressed_key && last_pressed_key.id == src.id && world.time - last_pressed_key.timestamps["released"] <= KEY_LIFE)
			src.taps = last_pressed_key.taps + 1
			if(src.maximum_taps > 0 && src.taps > src.maximum_taps)
				src.taps = 1
		else
			src.taps = 1

		gamepad.set_last_pressed_key(src)

		for(var/datum/key_action in src.key_events)
			if(hascall(key_action, "on_key_press"))
				call(key_action, "on_key_press")(client, src)

	proc/key_up(var/client/client)
		src.state = 0
		src.timestamps["released"] = world.time
		src.duration = world.time - src.timestamps["pressed"]

		for(var/datum/key_action in src.key_events)
			if(hascall(key_action, "on_key_release"))
				call(key_action, "on_key_release")(client, src)

	movement
	New(id, name, maximum_taps, direction)
		src.id = id
		src.name = name
		if(maximum_taps)
			src.maximum_taps = maximum_taps
		if(direction)
			src.dir = direction*/
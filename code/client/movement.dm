

#define MOVEMENT_KEYS list(KEY_NORTH, KEY_SOUTH, KEY_EAST, KEY_WEST)
#define ACTION_IDLE		1
#define ACTION_RUN		2
#define ACTION_DASH		3
#define ACTION_STUN		4
#define ACTION_ATTACK	5
#define ACTION_DEFEND	6

client
	var/tmp/movement_direction = 0
	var/tmp/moving

	proc/can_move()
		. = 1
		var/actor/actor = src.mob
		if(actor.action == global.actions[ACTION_DASH])
			return 0

	proc/move()
		if(src.moving)
			return 0

		src.moving = 1
		//src.movement_direction = src.gamepad.get_pad_direction()
		//if(!src.movement_direction)
		//	return 0

		src.Move(src.mob.loc, src.movement_direction)

		sleep(1)

		spawn()
			src.movement_direction = src.update_keys()

			while(src.movement_direction)
				src.Move(src.mob.loc, src.movement_direction)
				sleep(world.tick_lag)
				src.movement_direction = src.update_keys()

			if(src)
				src.moving = 0
				if(src.mob.icon_state == "run")
					src.mob.icon_state = null


	proc/update_keys(var/direction, var/state)
		. = 0
		if(KEY_NORTH in src.gamepad.active_inputs) . |= NORTH
		if(KEY_SOUTH in src.gamepad.active_inputs) . |= SOUTH
		if(KEY_EAST in src.gamepad.active_inputs) . |= EAST
		if(KEY_WEST in src.gamepad.active_inputs) . |= WEST
/*
	proc/update_keys()
		var/mdir
		var/compatible = 0
		var/keycount = 0
		var/mostrecent
		for(var/i in MOVEMENT_KEYS)
			if(gamepad.keys[i]["state"])
				keycount++ //count how many keys are pressed to see if compatibility is possible
				if(mostrecent) //if there is a most recent, check to see if current in loop is more recent
					if(gamepad.keys[i]["state"] > gamepad.keys[mostrecent]["state"])
						mostrecent = i
				else //if there is no most recent, use current in loop
					mostrecent = i


		if(keycount == 2) //continue compatibility check; more or less than two keys can not be compatible
			if(gamepad.keys[KEY_NORTH]["state"])
				if(gamepad.keys[KEY_WEST]["state"])
					mdir = NORTHWEST
					compatible = 1
				else if(gamepad.keys[KEY_EAST]["state"])
					mdir = NORTHEAST
					compatible = 1
			else if(gamepad.keys[KEY_SOUTH]["state"])
				if(gamepad.keys[KEY_WEST]["state"])
					mdir = SOUTHWEST
					compatible = 1
				else if(gamepad.keys[KEY_EAST]["state"])
					mdir = SOUTHEAST
					compatible = 1


		if(!compatible) //if two keys being pressed are compatible we do not want to move with the most recent
			switch(mostrecent)
				if("northwest") mdir = NORTHWEST
				if("northeast") mdir = NORTHEAST
				if("north") mdir = NORTH
				if("east") mdir = EAST
				if("southwest") mdir = SOUTHWEST
				if("southeast") mdir = SOUTHEAST
				if("south") mdir = SOUTH
				if("west") mdir = WEST

		return mdir*/
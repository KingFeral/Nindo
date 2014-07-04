

actor
	parent_type = /MapPaths/Pather

	var/tmp/action/action
	var/tmp/action_timestamp
	var/tmp/last_action_timestamp
	var/tmp/action/last_action

	New()
		..()
		src.action = global.actions[ACTION_IDLE]
		src.action.start(src)

	Crossed(actor/actor)
		if(istype(actor) && actor.action == global.actions[ACTION_DASH])
			return 1
		else
			return ..()

	Uncrossed(actor/actor)
		if(istype(actor) && actor.action == global.actions[ACTION_DASH])
			return 1
		else
			return ..()

	can_move()
		. = ..()
		if(.)
			if(src.action != global.actions[ACTION_STUN])
				return 1

	proc/set_last_action(action/action)
		src.last_action = action
		src.last_action_timestamp = world.time

	proc/set_action(action/action)
		src.action = action
		src.action_timestamp = world.time

	proc/can_act(action/action, list/params)
		. = 1
		if(!src.can_move())
			return 0

	proc/act(action/action, list/params)
		if((!src.can_act(action, params) || !action.can_start(src, params)) && (!params || params && !params["false"]))
			return 0

		//put this functionality inside action.start()
		src.action.end(src)
		//src.action = action
		//src.action_timestamp = world.time
		action.start(src, params)

	proc/idle()
		var/action/idle = global.actions[ACTION_IDLE]
		src.act(idle, null)

	proc/dash()
		var/action/dash = global.actions[ACTION_DASH]
		src.act(dash, null)
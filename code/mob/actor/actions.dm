

var/global/list/actions = list(
	new/action/idle,
	new/action/run,
	new/action/dash,
	new/action/stun,
	new/action/attack,
	new/action/defend,
	)


action
	var/id

	proc/can_start(var/actor/user, var/list/params)
		. = 1
		if(user.action == global.actions[ACTION_STUN] && (!params || params && !params["force"]))
			return 0

	proc/start(var/actor/user, var/list/params)
		//action has started, do stuff.
		user.set_action(src)

	proc/end(var/actor/user)
		//action has ended, do stuff.
		user.set_last_action(src)

	idle
		id = "idle"

		start(var/actor/user)
			. = ..()
			user.icon_state = ""

	run
		id = "run"

	dash
		id = "dash"

		can_start(var/actor/user)
			. = ..()
			if(.)
				if(user.last_action && user.last_action.id == src.id && world.time - user.last_action_timestamp < DASH_DELAY)
					return 0

		start(actor/user)
			. = ..()
			var/recorded_time = user.action_timestamp
			var/amount_of_steps = 10
			var/direction = user.dir

			//user.icon_state = "dash"
			animate(user, icon_state = "dash")

			for(var/steps in 1 to amount_of_steps)
				if(user.action != src || user.action_timestamp != recorded_time)
					break

				sleep(0.50)

				var/collision_layer = (steps == amount_of_steps) ? COLLIDE_MOBS : null
				var/can_dash = canStep(user, user.loc, direction, layer = collision_layer, pixel_distance = RUN_SPEED)

				if(can_dash)
					var/old_density = user.density

					user.density = 0

					step(user, user.dir, RUN_SPEED)

					user.density = old_density
				else
					break

			if(user.action == src && user.action_timestamp == recorded_time)
				user.idle()

		end(actor/user)
			//user.icon_state = ""
			animate(user, icon_state = "")
			. = ..()
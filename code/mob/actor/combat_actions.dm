

action
	stun
		id = "stun"

		start(var/actor/user, var/list/params)

	attack
		id = "attack"

		can_start(var/actor/user, var/list/params)
			. = ..()
			if(.)
				if(user.last_action && user.last_action.id == src.id && world.time - user.last_action_timestamp < ATTACK_DELAY)
					return 0

		start(var/actor/user, var/list/params)
			. = ..()
			var/recorded_time = user.action_timestamp
			var/attack_animation = pick("attack_1", "attack_2", prob(60); "attack_3",  prob(60); "attack_4",)

			if(user.action != src || user.action_timestamp != recorded_time)
				return 0

			//flick(attack_animation, user)
			animate(user, icon_state = attack_animation, time = 4)
			animate(icon_state = "")

			//for(var/character/hit in get_pixel_step())

			//if(


	defend
		id = "attack"

		start(var/actor/user, var/list/params)
			. = ..()
			user.icon_state = "defend"
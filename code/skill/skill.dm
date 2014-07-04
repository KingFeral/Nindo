

skill
	parent_type = /obj
	var/initial_stamina_cost
	var/initial_chakra_cost
	var/initial_cooldown
	var/cooldown
	var/initial_seal_time

	Click()
		var/combatant/user = usr
		if(user)
			src.use(usr)

	proc/error(combatant/user, message)
		if(user.client)
			user << "Could not use [src.name]: [message]"
		return 0

	proc/get_stamina_cost(combatant/user)
		return src.initial_stamina_cost

	proc/get_chakra_cost(combatant/user)
		return src.initial_chakra_cost

	proc/get_seal_time(combatant/user)
		return src.initial_seal_time

	proc/can_use(combatant/user)
		//if(user.stamina.amount < src.get_stamina_cost(user))	return src.error(user, "Insufficient Stamina ([user.stamina.amount]/[src.get_stamina_cost(user)]).")
		//if(user.chakra.amount < src.get_chakra_cost(user))		return src.error(user, "Insufficient Chakra ([user.chakra.amount]/[src.get_chakra_cost(user)]).")
		return 1

	proc/use(combatant/user)
		if(!src.can_use(user)) return 0

		var/successful_use = src.get_seal_time(user) ? src.do_seals(user) : 1
		if(!successful_use) return 0

		var/stamina_cost = src.get_stamina_cost(user)
		var/chakra_cost  = src.get_chakra_cost(user)

		//if(stamina_cost) src.stamina.reduce(stamina_cost)
		//if(chakra_cost) src.chakra.reduce(stamina_cost)

		src.used(user)

	proc/used(combatant/user)

	proc/do_seals(combatant/user)
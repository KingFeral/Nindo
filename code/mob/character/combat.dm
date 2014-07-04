
/*
character
	var/tmp/list/event_triggers = list("on_hit" = new/event) //our event triggers for various actions.

	proc/can_take_damage(combatant/attacker, list/params)
		return 1

	proc/take_damage(stamina_damage, combatant/attacker, list/params)
		if(!src.can_take_damage(attacker, params)) return 0

		var/event/on_hit_event = src.event_triggers["on_hit"]

		on_hit_event.send(stamina_damage, attacker)

	proc/on_hit(stamina_damage, attacker)
		//src has taken damage
		//do stuff...
		*/
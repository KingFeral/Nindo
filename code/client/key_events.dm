

var/global/list/key_events = list(
	new/key_event/movement,
	new/key_event/movement,
	new/key_event/movement,
	new/key_event/movement,
	new/key_event/action(global.actions[ACTION_ATTACK]),
	new/key_event/action(global.actions[ACTION_DEFEND]),
	)

key_event
	proc/on_key_press(var/client/client)
	proc/on_key_release(var/client/client)

	action
		var/tmp/action/action

		New(var/action/action)
			if(action)
				src.action = action

		on_key_press(var/client/client, var/key)
			if(src.action)
				var/actor/user = client.mob
				user.act(src.action)

		on_key_release(var/client/client, var/key)

	movement
		on_key_press(var/client/client, var/key)
			client.movement_direction = client.update_keys()

			if(client.gamepad.keys[key]["taps"] == 2)
				var/actor/user = client.mob
				user.dash()

			if(!client.moving)
				client.move()

		on_key_release(var/client/client, var/key)
			client.movement_direction = client.update_keys()

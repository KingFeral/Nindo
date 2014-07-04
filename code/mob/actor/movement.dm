

actor
	Moved()
		. = ..()
		if(.)
			if(src.action == global.actions[ACTION_DEFEND])
				src.idle()
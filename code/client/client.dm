

client
	perspective = EDGE_PERSPECTIVE | EYE_PERSPECTIVE
	//control_freak = 1

	New()
		. = ..()
		src.gamepad = new(src)
		src.macro_controller = new(src)
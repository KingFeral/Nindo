

atom
	movable
		var/tmp/can_move = TRUE
		var/tmp/turf/last_location

		Move(atom/location, direction, step_x, step_y)
			if(!src.can_move()) return 0

			var/atom/old_location = src.loc
			. = ..()
			if(.)
				src.Moved(old_location, location, direction, step_x, step_y)

		proc/Moved(var/atom/old_location, var/atom/new_location, var/direction, var/step_x, var/step_y)
			//call(old_location, "on_exit")(src)
			return 1

		proc/can_move()
			return src.can_move
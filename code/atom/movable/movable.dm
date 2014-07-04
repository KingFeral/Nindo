

atom/movable
	Crossed(var/atom/movable/m)
		if(!src.layer_updates)
			return ..()

		//world.log << "[m] has crossed"

		src.is_crossed++
		layer_handler.update(src)

		. = ..()

	Uncrossed(var/atom/movable/m)
		if(!src.layer_updates)
			return ..()

		//world.log << "[m] has uncrossed"

		src.is_crossed--
		if(src.is_crossed == 0)
			layer_handler.update(src)

		. = ..()
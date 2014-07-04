

character
	var/tmp/list/appearance = list()

	proc/add_appearance(var/image/appearance, var/id)
		//if(!src.appearance)
		//	src.appearance = list()

		if(id in src.appearance)
			src.remove_appearance(id)

		src.appearance[id] = appearance
		src.overlays += appearance
		world.log<<"appearance [appearance.icon] added"


	proc/remove_appearance(var/id)
		if(id in src.appearance)
			src.overlays -= src.appearance[id]
			src.appearance -= id
			//if(!src.appearance.len)
			//	src.appearance = null
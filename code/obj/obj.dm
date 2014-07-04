



obj
	rock
		icon = 'media/obj/misc.dmi'
		icon_state = "rock_3"
		//layer_updates = 1
		New()
			..()
			var/state = rand(1, 5)
			if(state in 1 to 2)
				src.density = 1
				src.bounds = "13, 13 to 44, 19"
				layer = MOB_LAYER + 0.1
			else
				layer = OBJ_LAYER
			src.icon_state = "rock_[state]"
			src.step_x += rand(-8, 8)
			src.step_y += rand(-8, 8)


	bush
		icon = 'media/obj/bush.dmi'
		//layer = MOB_LAYER
		bounds = "5, 4 to 44, 8"
		layer_updates = 1

	/*	Crossed(var/atom/movable/m)
			if(ismob(m))
				src.layer--
				src.LayerUpdate()

			. = ..()

		Uncrossed(var/atom/movable/m)
			if(ismob(m))
				src.layer++
				src.LayerUpdate()

			. = ..()*/

	tree
		icon 					= 'media/obj/tree.dmi'
		density 				= 0
		bounds					= "17, 17 to 48, 64"
		layer					= MOB_LAYER + 0.2
		var/tmp/overlapping 	= 0
		var/tmp/obj/trunk

		New()
			. = ..()
			var/turf/turf = get_step(src, SOUTH)
			if(turf)
				var/obj/o = new(turf)
				o.density = 1
				o.icon = src.icon
				o.icon_state = "trunk"
				o.layer = src.layer - 0.1
				o.bounds = "20, 1 to 44, 16"
				o.step_y = 24

				src.trunk = o
				src.trunk.loc = turf

		Crossed(atom/movable/m)
			if(ismob(m))
				src.overlapping++
				if(src.overlapping == 1)
					src.alpha = initial(src.alpha) / 1.6

		Uncrossed(atom/movable/m)
			if(ismob(m))
				src.overlapping--
				if(src.overlapping == 0)
					src.alpha = initial(src.alpha)


turf/tile
	grass
		icon = 'media/turf/tile/grass.dmi'
		tile_id = "grass"
		autojoin = 16

		JoinMatch(var/direction)
			var/turf/tile/t = get_step(src, direction)
			if(!t)
				return 1

			if(t.tile_id == "dirt")
				return 0
			else
				return 1

	dirt
		icon = 'media/turf/tile/dirt.dmi'
		tile_id = "dirt"



world
	New()
		..()
		initialized = 1

var
	initialized = 0

proc
	fix_autotile(at)
		. = 255
		if((at & 7)!=7)
			. ^= 2
		if((at & 28)!=28)
			. ^= 8
		if((at & 112)!=112)
			. ^= 32
		if((at & 193)!=193)
			. ^= 128
		. &= at

turf
	tile
		var/tmp/tile_id = "tile"
		autotile
			var
				prejoined = 0 //whether this autotile should be considered already initialized by the automerge utility
				list/autotile_matches //the list of tile_ids this tile will merge with.
			proc
				retile()
					var/list/l = list(get_step(src,NORTH),get_step(src,NORTHEAST),get_step(src,EAST),get_step(src,SOUTHEAST),get_step(src,SOUTH),get_step(src,SOUTHWEST),get_step(src,WEST),get_step(src,NORTHWEST))
					. = 0
					for(var/count=1;count<9;count++)
						if(hasmatch(l[count]))
							. += 2 ** (count-1)
					. = fix_autotile(.)
					src.icon_state = "[.]"

				hasmatch(turf/tile/t)
					if(t==null)
						return 1
					if(!istype(t,/turf/tile))
						return 0
					if(autotile_matches && t.tile_id in src.autotile_matches)
						return 1
					return 0

			New()
				if(global.initialized)
					retile()
				..()
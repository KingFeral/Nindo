

var/global/layer_handler/layer_handler = new()

atom/movable
	var/tmp/layer_updates
	var/tmp/is_crossed


layer_handler
	proc/update(var/atom/movable/a)
		if(a.is_crossed)
			a.layer = MOB_LAYER - 1
		else
			a.layer = MOB_LAYER

		a.LayerUpdate()



atom/movable
    var standing = TRUE

    proc/LayerUpdate()
        if(standing && z)
            layer = /*MOB_LAYER*/src.layer - Py() / map_height() * 1e-3

    New()
        ..()
        standing && z && LayerUpdate()

    Move()
        . = ..()
        . && standing && z && LayerUpdate()

//  edit
atom/movable
    proc/Py() return (y - 1) * tile_height() + bound_y + step_y

var __tile_height
proc/tile_height()
    if(!__tile_height)
        __tile_height = isnum(world.icon_size) ? world.icon_size : text2num(copytext(world.icon_size, findtext(world.icon_size, "x") + 1))
    return __tile_height

proc/map_height() return world.maxy * tile_height()
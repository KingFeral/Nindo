

item
	parent_type = /obj

	usable

/* Ter13/item respawning example.


obj
    itemspawn
        var
            obj/item/item
            itemspawn //set this to a type in the map editor
            respawn_time = 3000

        Uncrossed(atom/movable/o)
            if(o==item)
                item = null
                spawn(respawn_time)
                    item = new itemspawn()
                    item.Move(src.loc,SOUTH,src.step_x,src.step_y)

        New()
            ..()
            item = new itemspawn()
            item.Move(src.loc,SOUTH,src.step_x,src.step_y)

obj
    item
        verb
            Get()
                set src in oview(1)
                src.Move(usr)*/
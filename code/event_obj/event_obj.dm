

event
	var
		registered_objs[]
	proc
		add(src_obj, proc_name)
			if(!registered_objs)
				registered_objs = list(new /event_entry(src_obj, proc_name))
			else
				var/already_registered = 0

				// I wonder if I should make this an associative list with ["\ref[src_obj]:[proc_name]"] or something...
				// Well, it's an implementation detail anyway so this should be fine for now.
				for(var/event_entry/E in registered_objs)
					if(E.src_obj == src_obj && E.proc_name == proc_name)
						already_registered = 1
						break

				if(!already_registered && hascall(src_obj, proc_name))
					registered_objs += new /event_entry(src_obj, proc_name)

		remove(src_obj, proc_name)
			if(registered_objs)
				for(var/event_entry/E in registered_objs)
					if(E.src_obj == src_obj && E.proc_name == proc_name)
						registered_objs -= E
						break
				if(registered_objs.len < 1)
					registered_objs = null

		send()
			if(registered_objs)
				var/list/new_args = args.Copy()
				//new_args["event"] = src

				for(var/event_entry/E in registered_objs)
					// TODO: Maybe have a way to break out of this loop or something?
					if(E.src_obj) call(E.src_obj, E.proc_name)(arglist(new_args))
					else registered_objs -= E //< Remove dead events that had their obj forcibly deleted for some reason
				return 1
			return 0

event_entry
	var
		src_obj
		proc_name

	New(sobj, procn)
		. = ..()
		src_obj = sobj
		proc_name = procn



//InputHandler
//written by Terrey West (Ter13)
//(c) Sept 15, 2013
//This library sets up a simple means of registering control schemes for use by players.
//controls are registered by key name to an axis ID.
//Rather than building control behavior into mobs, it should rightly be part of client
//behavior. This system permits developers to easily register keyboard and mouse contorls
//as well as determine the order in which actions have occured, as well as quickly
//and easily use key combinations or even input combos to call functions.

controller
	var
		client/client
		list/mouse_event = list()
		list/event_buffer
		buffer_size = 0
		list/macros = list()
		list/inputs = list()
		active_inputs = 0
	proc
		keyPress(var/axis)
			inputs[axis] = TRUE
			var/t = world.time
			inputs["[axis]_time"] = t
			if(buffer_size)
				var/key = macros[axis]
				var/input_event/ev
				if(event_buffer.len<buffer_size)
					ev = new/input_event()
				else
					ev = event_buffer[1]
					event_buffer.Remove(ev)
				if(key=="mouse1"||key=="mouse2"||key=="mouse3")
					ev.assign(axis,1,t,mouse_event["object"],mouse_event["location"],mouse_event["control"],mouse_event["params"])
				else
					ev.assign(axis,1,t)
				event_buffer.Add(ev)
			handle_input(axis,1,t)

		keyRelease(var/axis)
			inputs[axis] = FALSE
			var/t = world.time - inputs["[axis]_time"]
			inputs["[axis]_time_released"] = inputs["[axis]_time"] // time released
			inputs["[axis]_time"] = t // time held

			if(buffer_size)
				var/key = macros[axis]
				var/input_event/ev
				if(event_buffer.len<buffer_size)
					ev = new/input_event()
				else
					ev = event_buffer[1]
					event_buffer.Remove(ev)
				if(key=="mouse1"||key=="mouse2"||key=="mouse3")
					ev.assign(axis,0,t,mouse_event["object"],mouse_event["location"],mouse_event["control"],mouse_event["params"])
				else
					ev.assign(axis,0,t)
				event_buffer.Add(ev)
			handle_input(axis,0,world.time)

		registerMacro(var/macro,var/axis,var/key,var/params=null)
			macros[key] = axis
			inputs["[axis]"] = 0
			inputs["[axis]_key"] = key
			inputs["[axis]_time"] = 0
			if(key!="mouse1"&&key!="mouse2"&&key!="mouse3")
				winset(client,"[axis]Dn","parent=[macro];name=[key];command=\"keyDown [axis]\";[params]")
				winset(client,"[axis]Up","parent=[macro];name=[key]+UP;command=\"keyUp [axis]\";[params]")

		removeMacro(var/macro,var/axis)
			var/key = inputs["[axis]_key"]
			macros.Remove(key)
			inputs.Remove("[axis]")
			inputs.Remove("[axis]_key")
			inputs.Remove("[axis]_time")
			if(key!="mouse1"&&key!="mouse2"&&key!="mouse3")
				winset(client,"[macro].[axis]Up","parent=")
				winset(client,"[macro].[axis]Dn","parent=")

		initialize()
			if(buffer_size)
				event_buffer = new/list()

		cleanup()
			for(var/v in macros)
				removeMacro(macros[v])

		handle_input(var/axis,var/value,var/time)
			if(value)
				active_inputs++
			else
				active_inputs--

	New(var/client/owner)
		src.client = owner
		initialize()
		..()
	Del()
		cleanup()
		..()

input_event
	var
		axis
		value
		object
		location
		control
		list/params
		time
	proc
		assign(var/ax,var/v,var/t,var/obj=null,var/loc=null,var/ctrl=null,var/pl=null)
			axis = ax
			value = v
			time = t
			object = obj
			location = loc
			control = ctrl
			params = pl

client
	var
		controller/gamepad/controller
	verb
		keyDown(axis as text)
			set hidden = 1
			if(src.controller)
				src.controller.keyPress(axis)

		keyUp(axis as text)
			set hidden = 1
			if(src.controller)
				src.controller.keyRelease(axis)

	MouseDown(object,location,control,params)
		if(src.controller)
			var/m1 = src.controller.macros["mouse1"]
			var/m2 = src.controller.macros["mouse2"]
			var/m3 = src.controller.macros["mouse3"]
			if(m1||m2||m3)
				var/list/l = params2list(params)
				var/mb
				if(l["left"]&&m1)
					mb = m1
				else if(l["middle"]&&m3)
					mb = m3
				else if(l["right"]&&m2)
					mb = m2
				else
					return
				controller.mouse_event["object"] = object
				controller.mouse_event["location"] = location
				controller.mouse_event["control"] = control
				controller.mouse_event["params"] = l
				controller.keyPress(mb)

	MouseUp(object,location,control,params)
		if(src.controller)
			var/m1 = src.controller.macros["mouse1"]
			var/m2 = src.controller.macros["mouse2"]
			var/m3 = src.controller.macros["mouse3"]
			if(m1||m2||m3)
				var/list/l = params2list(params)
				var/mb
				if(l["left"]&&m1)
					mb = m1
				else if(l["middle"]&&m3)
					mb = m3
				else if(l["right"]&&m2)
					mb = m2
				else
					return
				controller.mouse_event["object"] = object
				controller.mouse_event["location"] = location
				controller.mouse_event["control"] = control
				controller.mouse_event["params"] = l
				controller.keyRelease(mb)
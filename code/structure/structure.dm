

var/global/list/mouse_icons = list(
	"Leaf"			= 'media/structure/mouse_icons/leaf.dmi',
	"Mist"			= 'media/structure/mouse_icons/mist.dmi',
	"Sand"			= 'media/structure/mouse_icons/sand.dmi',
	"None"			= 'media/structure/mouse_icons/none.dmi',
)

var/global/list/chat_icons = list(
	"Leaf"			= 'media/structure/chat_icons/leaf.dmi',
	"Mist"			= 'media/structure/chat_icons/mist.dmi',
	"Sand"			= 'media/structure/chat_icons/sand.dmi',
	"None"			= 'media/structure/chat_icons/none.dmi',
)

character
	proc/refresh_mouse_icon()
		if(!src.village && !src.faction) return 0

		if(!src.faction)
			src.mouse_over_pointer = global.mouse_icons[src.village.name]
		else
			src.mouse_over_pointer = global.mouse_icons[src.faction.name]

structure
	var/name
	var/leader
	var/icon/mouse_icon
	var/icon/chat_icon
	var/list/promotional_items
	var/tmp/list/online_members = new()

	New(name, leader)
		src.name = name

		if(leader)
			src.leader = leader

		src.mouse_icon	= global.mouse_icons[mouse_icon]
		src.chat_icon	= global.chat_icons[chat_icon]

	proc/join(character/user)

	proc/leave(character/user)
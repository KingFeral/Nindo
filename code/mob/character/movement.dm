

var/const/WALK_SPEED = 5
var/const/RUN_SPEED  = 10

character
	step_size = WALK_SPEED

	Move(atom/location, direction, step_x, step_y)
		. = ..()
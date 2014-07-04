

character
	parent_type		= /actor
	icon			= 'media/base/base_white.dmi'
	bounds 			= "25, 17 to 41, 48"
	can_slide 		= TRUE
	step_x			= -16
	step_y			= -16

	Login()
		..()

	Logout()
		src.can_slide = FALSE

		for(var/atom/movable/a in bounds(src))
			a.Uncrossed(src)

		del(src)


/*


mob/verb/makeangles()
	var/icon/I=new(input(usr,"pick an icon")as icon)
	var/i=180
	while(i>=-180)
		var/angle=i
		var/icon/I2 = new(I)
		I2.Turn(angle)
		I.Insert(I2,"[i]")
		i-=10
	usr<<ftp(I,"[I.icon]")*/


login
	parent_type = /mob

	Login()
		var/login/old_mob = src

		src.client.mob = new/player

		old_mob.dispose()

/* Calling a ver through JS
window.location = byond://winset?command=someverb " + encodeURIComponent("someargument") + " " + encodeURIComponent("someargument2");

*/


/*
		var/t = {"
		<!doctype html>

		<html>
		<head>
			<script type = "text/javascript">
			</script>
		</head>
		<body>
			<a href = "?src=\ref[src];somelink=1;otherstuff=3">client/Topic() test</a>
			<form action = "submit.php" action = "post">
				<p><input type = "text" name = "username"></p>
				<p><input type = "password" name = "password"></p>
				<p><input type = "submit" value = "Login"></p>
			</form>
		</body>
		</html>

		"}
		src << browse(t, "window = login_browser_pane.browser")

client/Topic(href, list/href_list, hsrc)
	..()
	for(var/i in href_list)
		world.log << "[i]: [href_list[i]]"
*/


atom/movable
	//Queues [src] for garbage collection. Should almost always be called as the parent (to keep things simple).
	proc/dispose()
		src.tag = null
		src.loc = null
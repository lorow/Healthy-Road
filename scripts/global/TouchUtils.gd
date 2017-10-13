extends Node

func checkIfInside(event, position, size):
	# checks if event occuerd inside of potential listener

	if (event.pos.x>=position.x) \
		and (event.pos.x<position.x+size.x) \
		and (event.pos.y>=position.y) \
		and (event.pos.y<position.y+size.y):
		return true

func detectDirection(startPos, endPos):
	
	# 1 - right
	# 2 - left
	# 3 - up
	# 4 - down
	
	if startPos != null and endPos != null:
		var distanceX = endPos.x - startPos.x
		var distanceY = endPos.y - startPos.y
		if abs(distanceX) > abs(distanceY):
			if distanceX > 0: return 1
			else: return 2
		else:
			if distanceX > 0: return 3
			else: return 4
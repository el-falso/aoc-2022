extends Node2D


func _ready() -> void:
	print("Day I:")
	var arrayElves : Array = [[]]
	var arraySum : Array = []
	var currentElf : int = 0
	var fileData = FileAccess.open("res://Days/Day1/day_1.txt", FileAccess.READ)
	var line : String
	
	
	## ------ Part I ------
	
	# Populate 2D-Array with all the weights
	while not fileData.eof_reached():
		line = fileData.get_line()
		if line.is_empty():
			arrayElves.append([])
			currentElf += 1
		else:
			arrayElves[currentElf].append(int(line))

	# Populate an array with all sums
	for array in arrayElves:
		var currentSum := sumArray(array)
		arraySum.append(currentSum)
		
	
	print("Part I: %s Calories is the Elf with the most Calories carrying." % arraySum.max())
	
	## ------ Part 2 ------
	
	arraySum.sort()
	arraySum.reverse()
	
	var topThreeSum = 0
	
	for index in range(3):
		topThreeSum += arraySum[index]
	
	print("Part II: %s Calories are the top three Elves carrying in total." % topThreeSum)


func sumArray(array: PackedInt64Array) -> int:
	var sum : int = 0
	
	for number in array:
		sum += number
	
	return sum

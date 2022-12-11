extends Node2D

var fileData = FileAccess.open("res://Days/Day4/day_4.txt", FileAccess.READ)
var sectionArray : Array = []
var num = 0

func _ready() -> void:
	print("\nDay IV:")
	
	parseData()
	
	## ------ Part I ------
	for sections in sectionArray:
		if sections[0] >= sections[2] and sections[1] <= sections[3] or \
			sections[2] >= sections[0] and sections[3] <= sections[1]:
				num += 1
				
	print("Part I: In %s assignment pairs one range fully contain the other." % num)
	
	## ------ Part II ------
	num = 0
	for sections in sectionArray:
		if sections[1] >= sections[2] and sections[0] <= sections[3]:
			num += 1
	
	print("Part II: In %s assignment pairs the ranges overlap." % num)


func parseData() -> void:
	# Populate array with sections
	while not fileData.eof_reached():
		var line : String = fileData.get_line()
		var sections: PackedStringArray
		if not line.is_empty():
			sections = line.split(",")
			var firstSectionStart: int = int(sections[0].get_slice("-", 0))
			var firstSectionEnd: int = int(sections[0].get_slice("-", 1))
			var secondSectionStart: int = int(sections[1].get_slice("-", 0))
			var secondSectionEnd: int = int(sections[1].get_slice("-", 1))
			sectionArray.append([
				firstSectionStart,
				firstSectionEnd,
				secondSectionStart,
				secondSectionEnd
			])

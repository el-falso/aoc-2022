extends Node2D

var arrayRucksack : Array = []
var arrayCompartments : Array = []
var arrayGroups : Array = []

var priorities : Dictionary = {
	"a": 1, "b": 2, "c": 3, "d": 4, "e": 5, "f": 6, "g": 7,
	"h": 8, "i": 9, "j": 10, "k": 11, "l": 12, "m": 13,
	"n": 14, "o": 15, "p": 16, "q": 17, "r": 18, "s": 19, "t": 20,
	"u": 21, "v":22, "w": 23, "x": 24, "y": 25, "z": 26,
	"A": 27, "B": 28, "C": 29, "D": 30, "E": 31, "F": 32, "G": 33,
	"H": 34, "I": 35, "J": 36, "K": 37, "L": 38, "M": 39,
	"N": 40, "O": 41, "P": 42, "Q": 43, "R": 44, "S": 45, "T": 46,
	"U": 47, "V": 48, "W": 49, "X": 50, "Y": 51, "Z": 52
 }

func _ready() -> void:
	print("\nDay III:")

	var fileData = FileAccess.open("res://Days/Day3/day_3.txt", FileAccess.READ)
	var line : String
	var sumPriorities: int


	## ------ Part I ------
	
	# Populate array with items
	while not fileData.eof_reached():
		line = fileData.get_line()
		if not line.is_empty():
			arrayRucksack.append(line)
			
	# Populate another array with compartments
	for string in arrayRucksack:
		var stringHalfLength : int = string.length() / 2
		var split : Array = [string.substr(0, stringHalfLength), string.substr(stringHalfLength)]
		arrayCompartments.append(split)
		
	for compartments in arrayCompartments:
		var finishedChars : Array = []
		var stringFirst : String = compartments[0]
		var stringSecond : String = compartments[1]
		for char in stringFirst:
			var num : int = stringSecond.count(char)
			if num != 0 and char not in finishedChars:
				finishedChars.append(char)
				sumPriorities += getPriority(char)
			
	print("Part I: %s is the sum of the priorities of those item types." % sumPriorities)
	
	## ------ Part II ------
	
	var index : int = 0
	var subArray : Array = []
	for string in arrayRucksack:
		if index >= 3:
			subArray = []
			index = 0
		subArray.append(string)
		
		if index == 2:
			arrayGroups.append(subArray)
		index += 1
	
	var badges : Array = []
	
	sumPriorities = 0
	
	# Get group badge
	for i in arrayGroups.size():
		var group : Array = arrayGroups[i]
		
		for char in group[0]:
			if char in group[1] and char in group[2]:
				sumPriorities += getPriority(char)
				break
			
	print("Part II: %s is the sum of the priorities of those item types." % sumPriorities)
	
func getPriority(string: String) -> int:
	return priorities[string]

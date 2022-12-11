extends Node2D

enum ERoundOutcome {
	LOOSE = 0,
	DRAW = 3,
	WIN = 6
}

enum ESelectedShape {
	ROCK = 1,
	PAPER = 2,
	SCISSORS = 3
}

var arrayTournament : Array = []
var totalScore: int

func _ready() -> void:
	print("\nDay II:")

	var fileData = FileAccess.open("res://Days/Day2/day_2.txt", FileAccess.READ)
	var line : String

	
	## ------ Part I ------
	
	# Populate 2D-Array with all the weights
	while not fileData.eof_reached():
		line = fileData.get_line()
		if not line.is_empty():
			arrayTournament.append(Array(line.rsplit(" ")))
		
	# Calculate score
	calcTotalScore()
	
	print("Part I: %s would be the total score if everything goes exactly according to the strategy guide." % totalScore)
	
	## ------ Part II ------
	
	# Exchange Element
	for array in arrayTournament:
		var roundScore : int = 0
		match array:
			["A", "X"]: # Rock, Loose -> Scissors
				array[1] = "Z"
			["A", "Y"]: # Rock, Draw -> Rock
				array[1] = "X"
			["A", "Z"]: # Rock, Win -> Paper
				array[1] = "Y"
			
			["B", "X"]: # Paper, Loose -> Rock
				array[1] = "X"
			["B", "Y"]: # Paper, Draw -> Paper
				array[1] = "Y"
			["B", "Z"]: # Paper, Win -> Scissors
				array[1] = "Z"
				
			["C", "X"]: # Scissors, Loose -> Paper
				array[1] = "Y"
			["C", "Y"]: # Scissors, Draw -> Scissors
				array[1] = "Z"
			["C", "Z"]: # Scissors, Win -> Rock
				array[1] = "X"
	
	# Reset & Calculate score
	totalScore = 0
	calcTotalScore()
	
	print("Part II: %s would be the total score if everything goes exactly according to the strategy guide." % totalScore)


func calcTotalScore() -> void:
	for array in arrayTournament:
		var roundScore : int = 0
		match array:
			["A", "X"]: # Rock, Rock
				roundScore += ERoundOutcome.DRAW + ESelectedShape.ROCK
			["A", "Y"]: # Rock, Paper
				roundScore += ERoundOutcome.WIN + ESelectedShape.PAPER
			["A", "Z"]: # Rock, Scissors
				roundScore += ERoundOutcome.LOOSE + ESelectedShape.SCISSORS
			
			["B", "X"]: # Paper, Rock
				roundScore += ERoundOutcome.LOOSE + ESelectedShape.ROCK
			["B", "Y"]: # Paper, Paper
				totalScore += ERoundOutcome.DRAW + ESelectedShape.PAPER
			["B", "Z"]: # Paper, Scissors
				roundScore += ERoundOutcome.WIN + ESelectedShape.SCISSORS
				
			["C", "X"]: # Scissors, Rock
				roundScore += ERoundOutcome.WIN + ESelectedShape.ROCK
			["C", "Y"]: # Scissors, Paper
				roundScore += ERoundOutcome.LOOSE + ESelectedShape.PAPER
			["C", "Z"]: # Scissors, Scissors
				roundScore += ERoundOutcome.DRAW + ESelectedShape.SCISSORS
		
		totalScore += roundScore
			


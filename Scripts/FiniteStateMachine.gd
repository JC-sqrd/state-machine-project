class_name FiniteStateMachine
extends Node
 
@export var initial_state : State
@export var final_states : Array[State]
@export var input_string : String 

var current_state : State
var current_transition_states : Array[State]
var input_index : int = 0

var states : Array[State]

func _ready() -> void:
	for child in get_children():
		if child is State:
			states.append(child)
	print("Input string accepted: " + str(start_machine()))

func start_machine() -> bool:
	current_state = initial_state
	if current_state != null:
		current_transition_states = [current_state]
	for i in input_string.length():
		var next_states : Array[State] = []
		print("Current string index: " + str(i))
		for transition_state in current_transition_states:
			next_states += (transition_state.transition(input_string, i))
		current_transition_states = next_states
		print("Current transition states: " + str(current_transition_states))
	for transition_state in current_transition_states:
		if final_states.has(transition_state):
			return true
		pass
	#print("Current transition states: " + str(current_transition_states))
	return false

func set_initial_state():
	
	pass

func set_final_state():
	
	pass

func remove_final_state():
	
	pass

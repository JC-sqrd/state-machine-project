class_name State
extends Node

var transitions : Array[StateTransition]

func _ready() -> void:
	for child in get_children():
		if child is StateTransition:
			transitions.append(child)
			pass
		pass
	pass

func transition(input : String, input_index : int) -> Array[State]:
	enter_state(input, input_index)
	var transition_states : Array[State]
	print("State: " + name +  " | Evaluating transitions")
	if transitions.size() != 0 and input_index < (input.length()):
		for state_transition in transitions:
			if state_transition.transition_string == input[input_index]:
				transition_states.append(state_transition.transition_to)
				pass
			pass
		pass
	return transition_states

func add_transition(state_transition : StateTransition):
	transitions.append(state_transition)
	pass

func enter_state(input : String, input_index : int):
	
	pass

func exit_state():
	
	pass

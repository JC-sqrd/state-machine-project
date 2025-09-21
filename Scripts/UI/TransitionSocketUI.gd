class_name TransitionSocketUI
extends Control


var state_ui : StateUI
var draw_transition_line : bool = false

var _local_mouse_pos : Vector2
var transitions : Array[StateTransition]

signal pressed(transition_socket_ui : TransitionSocketUI)
signal mouse_hovered(transition_socket_ui : TransitionSocketUI)
signal mouse_unhovered(transition_socket_ui : TransitionSocketUI)

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered_transition_socket)
	mouse_exited.connect(_on_mouse_exited_transition_socket)

func create_transition_to_state(state : State):
	
	pass

func _on_mouse_entered_transition_socket():
	mouse_hovered.emit(self)
	pass

func _on_mouse_exited_transition_socket():
	mouse_unhovered.emit(self)
	pass

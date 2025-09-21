class_name StateTransitionUI
extends Control

var from : StateUI
var to : StateUI

var state_transition : StateTransition

func _ready() -> void:
	if from != null:
		from.update_position.connect(_on_state_ui_update_position)
		pass
	if to != null:
		to.update_position.connect(_on_state_ui_update_position)

func _on_state_ui_update_position():
	queue_redraw()
	pass


func _draw() -> void:
	draw_line(from.out_transition_socket.global_position + from.out_transition_socket.size / 2, to.in_transition_socket.global_position + to.in_transition_socket.size / 2, Color.GREEN, 5)
	draw_circle(to.in_transition_socket.global_position + to.in_transition_socket.size / 2, 5, Color.RED, true, 4, true)
	pass

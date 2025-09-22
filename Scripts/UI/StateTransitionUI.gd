class_name StateTransitionUI
extends Control

var from : StateUI
var to : StateUI

var state_transition : StateTransition
@onready var line_2d: Line2D = %Line2D

func _ready() -> void:
	if from != null:
		from.update_position.connect(_on_state_ui_update_position)
		pass
	if to != null:
		to.update_position.connect(_on_state_ui_update_position)
	calculate_position()

func _on_state_ui_update_position():
	calculate_position()
	#queue_redraw()
	pass

func calculate_position():
	line_2d.clear_points()
	#var direction : Vector2 = (to.global_position + to.in_transition_socket.size / 2) - (from.global_position + from.out_transition_socket.size)
	var difference : Vector2 = to.in_transition_socket.global_position - from.out_transition_socket.global_position
	global_position = from.out_transition_socket.global_position + difference / 2
	var from_point : Vector2 = global_position -  (from.out_transition_socket.global_position - from.out_transition_socket.size / 2)
	var to_point : Vector2 = global_position - (to.in_transition_socket.global_position - to.in_transition_socket.size / 2)
	line_2d.add_point(to_point)
	line_2d.add_point(from_point)
	pass

func _draw() -> void:
	return
	var from_point : Vector2 = global_position - (from.out_transition_socket.global_position - from.out_transition_socket.size / 2)
	var to_point : Vector2 = global_position - (to.in_transition_socket.global_position - to.in_transition_socket.size / 2)
	draw_line(from_point, to_point, Color.GREEN, 5)
	draw_circle(from_point, 5, Color.RED, true, 4, true)
	pass

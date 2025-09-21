class_name MainUI
extends Control

enum UI_State {NEUTRAL, MOVE_STATE, SELECT_STATE_TO_TRANSITION}

var state_uis : Array[StateUI]
@onready var state_label: Label = %StateLabel
var current_ui_state : UI_State = UI_State.NEUTRAL : set = _set_current_ui_state
var selected_transition_socket : OutTransitionSocketUI

var left_mouse_button_held : bool = false

const STATE_TRANSITION = preload("res://Scenes/UI/state_transition.tscn")

func _ready() -> void:
	for child in get_children():
		if child is StateUI:
			child.mouse_hovered.connect(_on_state_ui_hovered)
			child.mouse_unhovered.connect(_on_state_ui_unhovered)
			child.out_transition_socket.mouse_hovered.connect(_on_transition_socket_hovered)
			child.out_transition_socket.mouse_unhovered.connect(_on_transition_socket_unhovered)
			child.out_transition_socket.pressed.connect(_on_transition_socket_pressed)
			state_uis.append(child)
			pass
	pass

#func _input(event: InputEvent) -> void:
	#print("INPUT EVENT: " + str(event))

func _process(delta: float) -> void:
	if left_mouse_button_held:
		var hovered : Control = get_viewport().gui_get_hovered_control()
		if hovered != null and hovered is StateUI:
			hovered = hovered as StateUI
			var mouse_dir : Vector2 = get_global_mouse_position() - hovered.global_position  
			hovered.global_position = get_global_mouse_position() - hovered.size / 2#mouse_dir
			hovered.update_position.emit()
			current_ui_state = UI_State.MOVE_STATE

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			left_mouse_button_held = true
			var hovered : Control = get_viewport().gui_get_hovered_control()
			if hovered != null and hovered is OutTransitionSocketUI and current_ui_state != UI_State.SELECT_STATE_TO_TRANSITION:
				current_ui_state = UI_State.SELECT_STATE_TO_TRANSITION
				selected_transition_socket = hovered
				print("Hovered control: " + hovered.name)
				return
			elif hovered != null and hovered is InTransitionSocketUI and current_ui_state == UI_State.SELECT_STATE_TO_TRANSITION:
				current_ui_state = UI_State.NEUTRAL
				hovered = hovered as InTransitionSocketUI
				if selected_transition_socket != null:
					#Set transition to state
					var state_transition : StateTransition = selected_transition_socket.create_transition_to_state(hovered.state_ui.state)
					var state_transition_ui : StateTransitionUI = STATE_TRANSITION.instantiate() as StateTransitionUI
					state_transition_ui.state_transition = state_transition
					state_transition_ui.from = selected_transition_socket.state_ui
					state_transition_ui.to = hovered.state_ui
					
					add_child(state_transition_ui)
					
					selected_transition_socket.state_ui.state.add_transition(state_transition)
					selected_transition_socket.state_ui.state.add_child(state_transition)
					print("SUCESSFULLY SET TRANSITION")
					pass
				print("Hovered control: " + hovered.name)
				pass
			elif hovered != null:
				print("Hovered control: " + hovered.name)
				pass
			current_ui_state = UI_State.NEUTRAL
			print("LEFT MOUSE BUTTON PRESSED")
			pass
		elif event.button_index == MOUSE_BUTTON_LEFT:
			left_mouse_button_held = false
		pass
	pass

func _on_state_ui_hovered(state_ui : StateUI):
	state_ui.modulate = Color.PALE_GREEN
	pass

func _on_state_ui_unhovered(state_ui : StateUI):
	state_ui.modulate = Color.WHITE
	pass

func _on_transition_socket_hovered(transition_socket : OutTransitionSocketUI):
	transition_socket.modulate = Color.GREEN
	pass

func _on_transition_socket_unhovered(transition_socket : OutTransitionSocketUI):
	transition_socket.modulate = Color.WHITE
	pass

func _on_transition_socket_pressed(transition_socket : OutTransitionSocketUI):
	#print("PRESSED: " + transition_socket.state_ui.name)
	pass

func _set_current_ui_state(new_state : UI_State):
	current_ui_state = new_state
	_state_label_debug(current_ui_state, state_label)
	pass

func _state_label_debug(current_ui_state : UI_State, label : Label):
	if current_ui_state == UI_State.NEUTRAL:
		label.text = "NEUTRAL"
	elif current_ui_state == UI_State.MOVE_STATE:
		label.text = "MOVE STATE POSITION"
	elif current_ui_state == UI_State.SELECT_STATE_TO_TRANSITION:
		label.text = "SELECT STATE TO TRANSITION"
	pass

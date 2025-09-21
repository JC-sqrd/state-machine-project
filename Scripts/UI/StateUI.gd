class_name StateUI
extends Control


@onready var transition_socket: TransitionSocketUI = %TransitionSocket
var state : State

signal mouse_hovered(state_ui : StateUI)
signal mouse_unhovered(state_ui : StateUI)

func _ready():
	transition_socket.pressed.connect(_on_transition_socket_pressed)
	transition_socket.state_ui = self
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	state = State.new()
	pass

func _on_mouse_entered():
	mouse_hovered.emit(self)
	pass

func _on_mouse_exited():
	mouse_unhovered.emit(self)
	pass

func _on_transition_socket_pressed(transition_socket_ui : TransitionSocketUI):
	pass

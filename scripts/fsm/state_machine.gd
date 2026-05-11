class_name StateMachine
extends Node


var states : Dictionary[String, State] = {}
var current_state : State
var default_state : State


func _ready() -> void:
	for child in get_children():
		if child is State:
			if !states.has(child.get_id()):
				states[child.get_id()] = child
	
	default_state = states.get(IdleState.ID)
	if default_state: 
		transition_to(default_state.get_id(), null)


func _process(delta):
	if current_state: current_state.process(delta)


func _physics_process(delta):
	if current_state: current_state.physics_process(delta)


func transition_to(state_id: String, params: StateParams) -> void:
	if current_state:
		current_state.cancel()
	var state = states.get(state_id)
	if state:
		current_state = state
		current_state.init(params)
	else:
		current_state = default_state
	
	if !current_state.canceled.is_connected(_on_current_state_canceled):
		current_state.canceled.connect(_on_current_state_canceled)
	if !current_state.exited.is_connected(_on_current_state_exited):
		current_state.exited.connect(_on_current_state_exited)
	current_state.enter()
	print("Transitioned to " + current_state.get_id())


func _on_current_state_canceled() -> void:
	current_state.canceled.disconnect(_on_current_state_canceled)
	current_state.exited.disconnect(_on_current_state_exited)
	transition_to(default_state.get_id(), null)


func _on_current_state_exited() -> void:
	current_state.canceled.disconnect(_on_current_state_canceled)
	current_state.exited.disconnect(_on_current_state_exited)
	transition_to(default_state.get_id(), null)

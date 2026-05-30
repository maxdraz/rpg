class_name StateMachine
extends Node

@export var default_state: State

var states: Dictionary[Script, State]
var current_state: State


func _ready() -> void:
	for child in get_children():
		if child is not State: continue
		states[child.get_script()] = child
	
	if default_state:
		transition_to(default_state.get_script(), null)


func transition_to(state_class: Script, params: Variant) -> void:
	if !state_class or (current_state && state_class == current_state.get_script()): return
	var state = states.get(state_class)
	if !state: return
	if current_state:
		current_state.cancel()
	current_state = state
	current_state.init(params)
	current_state.enter()

class_name StateMachine
extends EntityComponent

@export var default_state: State

var states: Dictionary[Script, State]
var current_state: State


func _ready() -> void:
	for child in get_children():
		if child is not State: continue
		states[child.get_script()] = child
	
	if default_state:
		transition_to(default_state.get_script(), null)


func _process(delta: float) -> void:
	if !current_state: return
	current_state.process(delta)


func _physics_process(delta: float) -> void:
	if !current_state: return
	current_state.physics_process(delta)


func transition_to(state_class: Script, params: Variant) -> void:
	if !state_class: return
	var state = states.get(state_class)
	if !state: return
	if current_state:
		current_state.cancel()
		current_state.exited.disconnect(_on_state_exited)
	current_state = state
	current_state.exited.connect(_on_state_exited)
	current_state.init(params)
	current_state.enter()


func _on_state_exited() -> void:
	current_state = null
	transition_to(default_state.get_script(), null)

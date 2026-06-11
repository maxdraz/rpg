class_name WanderBehaviour
extends AIBehaviour

@export var state_machine: StateMachine

func is_conditions_met() -> bool:
	return state_machine.current_state is not WanderState


func execute() -> void:
	state_machine.transition_to(WanderState, null)

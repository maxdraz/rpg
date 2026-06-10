class_name InteractionAttack
extends Interaction

@export var entity: Entity


func get_interaction_name() -> String:
	return "Attack"


func interact(interacting_entity: Entity):
	super.interact(interacting_entity)
	var params = CombatStateParams.new(interacting_entity, entity)
	var state_machine = interacting_entity.get_component(StateMachine)
	if state_machine is StateMachine:
		state_machine.transition_to(CombatState, params)

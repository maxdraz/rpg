class_name DefendBehaviour
extends AIBehaviour

@export var entity: Entity
@export var event_bus: EventBusComponent
@export var combat: CombatComponent
@export var state_machine: StateMachineComponent

var attacker: Entity


func _ready() -> void:
	event_bus.emitted.connect(_on_event)


func is_conditions_met() -> bool:
	return attacker != null


func execute() -> void:
	state_machine.transition_to(CombatState, CombatStateParams.new(entity, attacker))
	combat.target_changed.connect(_on_target_changed)
	print("attack behaviour executed")


func _on_event(event: Event) -> void:
	var event_damage_taken := event as EventDamageTaken
	if !event_damage_taken: return
	attacker = event_damage_taken.damage_dealer


func _on_target_changed(new_target: Entity) -> void:
	attacker = new_target
	if attacker == null:
		exit()


func exit() -> void:
	combat.target_changed.disconnect(_on_target_changed)
	super.exit()
class_name CombatComponent
extends EntityComponent

@export var entity: Entity
@export var event_bus: EventBusComponent
@export var damage := 10
@export var attack_interval := 2.0
@export var attack_range := 4.0
@export var target_position_check_interval := 0.6

var target: Entity
var cooldown_attack: float


func _process(delta) -> void:
	if cooldown_attack > 0:
		cooldown_attack -= delta   


func set_target(target: Entity) -> void:
	self.target = target


func is_in_range() -> bool:
	return target and target.global_position.distance_squared_to(entity.global_position) <= attack_range * attack_range


func is_attack_ready() -> bool:
	return cooldown_attack <= 0


func attack() -> void:
	print(target.name + " took " + str(damage) + " damage")
	cooldown_attack = attack_interval
	event_bus.emit(DamageDealtEvent.new(entity, target, damage), true) 

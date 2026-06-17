class_name CombatComponent
extends EntityComponent

@export var entity: Entity
@export var event_bus: EventBusComponent
@export var stats: StatsComponent
@export var health: HealthComponent
@export var attack_interval := 2.0
@export var attack_range := 4.0
@export var target_position_check_interval := 0.0

var target: Entity
var cooldown: float

signal target_changed(new_target: Entity)


func _process(delta) -> void:
	if cooldown > 0:
		cooldown -= delta   


func set_target(target: Entity) -> void:
	self.target = target
	target_changed.emit(target)


func is_in_attack_range() -> bool:
	var effective_attack_range = attack_range + 0.25
	return target and target.global_position.distance_squared_to(entity.global_position) <= effective_attack_range * effective_attack_range


func is_in_move_range() -> bool:
	return target and target.global_position.distance_squared_to(entity.global_position) <= attack_range * attack_range


func is_attack_ready() -> bool:
	return cooldown <= 0


func attack() -> void:
	validate_target()
	deal_damage()
	reset_cooldown()
	validate_target()


func deal_damage() -> void:
	if !target: return
	var target_health = target.get_component(HealthComponent) as HealthComponent
	if !target_health: return

	var strength = stats.get_base_stat(StatTypeStrength)
	if !strength: strength = 0.0
	var damage_data = DamageData.new()
	damage_data.damage = strength

	target_health.set_hp(target_health.hp - damage_data.damage)
	print(entity.name + " dealt " + str(damage_data.damage) + " dmg")
	event_bus.emit(EventDamageDealt.new(entity, target, damage_data), true)
	var target_event_bus := target.get_component(EventBusComponent)
	if target_event_bus: target_event_bus.emit(EventDamageTaken.new(entity, target, damage_data))


func reset_cooldown() -> void: 
	var attack_speed = stats.get_base_stat(StatTypeAttackSpeed)
	if !attack_speed: attack_speed = 1.0
	attack_speed = max(0.00125, attack_speed)
	cooldown = attack_interval / attack_speed


func validate_target() -> void:
	if !target: return
	var target_health = target.get_component(HealthComponent) as HealthComponent
	if !target_health: return
	if target_health.hp <= 0: 
		set_target(null)

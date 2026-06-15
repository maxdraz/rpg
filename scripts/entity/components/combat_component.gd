class_name CombatComponent
extends EntityComponent

@export var entity: Entity
@export var event_bus: EventBusComponent
@export var stats: StatsComponent
@export var health: HealthComponent
@export var attack_interval := 2.0
@export var attack_range := 4.0
@export var target_position_check_interval := 0.6

var target: Entity
var cooldown: float


func _process(delta) -> void:
	if cooldown > 0:
		cooldown -= delta   


func set_target(target: Entity) -> void:
	self.target = target


func is_in_range() -> bool:
	return target and target.global_position.distance_squared_to(entity.global_position) <= attack_range * attack_range


func is_attack_ready() -> bool:
	return cooldown <= 0


func attack() -> void:
	deal_damage()
	reset_cooldown()
	validate_target()


func deal_damage() -> void:
	if !target: return
	var target_health = target.get_component(HealthComponent) as HealthComponent
	if !target_health: return
	var damage = stats.get_base_stat(StatTypeStrength)
	if !damage: damage = 0.0
	target_health.set_hp(target_health.hp - damage)
	event_bus.emit(EventDamageDealt.new(entity, target, damage), true)


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

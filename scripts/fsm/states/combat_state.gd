class_name CombatState
extends State

@export var entity: Entity
@export var movement: MovementComponent
@export var combat: CombatComponent

var params: CombatStateParams
var position_check_cooldown : float


func init(params: Variant) -> void:
	if params is not CombatStateParams: return
	self.params = params


func enter() -> void:
	super.enter()
	movement.target_reached.connect(_on_target_reached)
	movement.try_move_to(params.target.global_position, combat.attack_range)
	combat.set_target(params.target)


func process(delta: float) -> void:
	super.process(delta)
	position_check_cooldown -= delta
	if position_check_cooldown <= 0 && !combat.is_in_move_range():
		movement.try_move_to(params.target.global_position, combat.attack_range)
		position_check_cooldown = combat.target_position_check_interval
	
	if combat.is_attack_ready() and combat.is_in_attack_range():
		combat.attack()
		entity.look_at(params.target.global_position, Vector3.UP, true)


func exit() -> void:
	super.exit()
	movement.target_reached.disconnect(_on_target_reached)
	combat.set_target(null)


func cancel() -> void:
	super.cancel()
	movement.target_reached.disconnect(_on_target_reached)
	combat.set_target(null)


func _on_target_reached() -> void:
	entity.look_at(params.target.global_position, Vector3.UP, true)

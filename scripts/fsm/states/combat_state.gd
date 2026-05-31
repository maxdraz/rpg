class_name CombatState
extends State

@export var move_to_state: MoveToState
@export var damage := 10
@export var attack_interval := 2.0
@export var attack_range := 4.0

var params: CombatStateParams
var attack_cooldown : float


func init(params: Variant) -> void:
	if params is not CombatStateParams: return
	self.params = params


func enter() -> void:
	super.enter()
	move_to_state.init(MoveToStateParams.new(params.target.position))

func process(delta: float) -> void:
	super.process(delta)	
	if attack_cooldown <= 0:
		if is_in_range():
			attack()
			attack_cooldown = attack_interval
	attack_interval -= delta


func is_in_range() -> bool:
	return params.owner.position.distance_squared_to(params.target.position) >= attack_range * attack_range

func attack() -> void:
	print(name + " deal damage " + str(damage))

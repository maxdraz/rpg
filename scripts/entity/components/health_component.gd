class_name HealthComponent
extends EntityComponent

@export var stats: StatsComponent
@export var event_bus: EventBusComponent
var hp: float

func _ready() -> void:
	var max_hp = stats.get_base_stat(StatTypeMaxHp)
	if max_hp:
		set_hp(max_hp)


func set_hp(new_value: float) -> void:
	var old_value = hp
	hp = new_value
	if event_bus:
		event_bus.emit(EventHealthChanged.new(new_value, old_value))

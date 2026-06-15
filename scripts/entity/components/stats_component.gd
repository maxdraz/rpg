class_name StatsComponent
extends EntityComponent

@export var stat_set: StatSet
var base_stats: Dictionary[Script, float]


func _ready() -> void:
	for key in stat_set.base_stats:
		base_stats[key.get_script()] = stat_set.base_stats[key]


func set_base_stat(type: Script, value: float) -> void:
	if !is_instance_of(StatType, type): return
	base_stats.set(type, value)


func get_base_stat(type: Script) -> Variant:
	if type.get_base_script() != StatType:
		return null
	return base_stats.get(type)

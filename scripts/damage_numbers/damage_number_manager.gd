extends Node

@export_file("*.tscn", "*.scn") var number_scene_path : String


func _ready() -> void:
	EventBus.emitted.connect(_on_event)


func _on_event(event: Event) -> void:
	var damage_dealt_event = event as EventDamageDealt
	if !damage_dealt_event: return
	var scene = load(number_scene_path)
	var damage_number = scene.instantiate() as DamageNumber
	add_child(damage_number)
	damage_number.initialize(damage_dealt_event.damage_taker.global_position, str(damage_dealt_event.damage_data.damage))

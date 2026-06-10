class_name Entity
extends Node3D

var components: Dictionary[Script, EntityComponent]


func _ready() -> void:
	for child in get_children():
		if child is EntityComponent:
			components[child.get_script()] = child


func get_component(component: Script) -> EntityComponent:
	return components.get(component)

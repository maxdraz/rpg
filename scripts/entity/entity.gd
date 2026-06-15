class_name Entity
extends Node3D

@export var component_container: Node
var components: Dictionary[Script, EntityComponent]


func _ready() -> void:
	for child in component_container.get_children():
		if child is EntityComponent:
			components.set(child.get_script(), child)


func get_component(component: Script) -> EntityComponent:
	return components.get(component)

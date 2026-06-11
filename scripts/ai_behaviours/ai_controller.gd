class_name AIController
extends Node

@export var container_behaviours: Node

var behaviours: Array[AIBehaviour]
var current_behaviour: AIBehaviour


func _ready() -> void:
	for child in container_behaviours.get_children(): 
		if child is AIBehaviour:
			behaviours.append(child)


func _process(delta: float) -> void:
	for behaviour in behaviours:
		if !current_behaviour and behaviour.is_conditions_met():
			current_behaviour = behaviour
			current_behaviour.execute()
			continue

		if current_behaviour != behaviour and behaviour.priority > current_behaviour.priority and behaviour.is_conditions_met():
				current_behaviour = behaviour
				current_behaviour.execute()

class_name Interactable
extends Area3D


@export var root_node: Node3D


func interact():
	print("interacting with " + root_node.name)

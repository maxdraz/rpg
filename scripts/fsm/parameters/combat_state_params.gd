class_name CombatStateParams
extends RefCounted

var owner: Node3D
var target: Node3D


func _init(owner: Node3D, target: Node3D) -> void:
	self.owner = owner
	self.target = target

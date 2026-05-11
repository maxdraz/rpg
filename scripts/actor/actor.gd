class_name Actor
extends CharacterBody3D


enum Alignment 
{ 
	NEUTRAL, 
	PLAYER, 
	HOSTILE
}


@export var agent : CharacterBodyNavigationAgent3D
@export var alignment : Alignment
@export var state_machine : StateMachine


func move_to(destination: Vector3) -> void:
	var params = MoveToStateParams.new(destination)
	state_machine.transition_to(MoveToState.ID, params)

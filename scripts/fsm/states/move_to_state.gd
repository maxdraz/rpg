class_name MoveToState
extends State


static var ID = &"MoveToState"

@export var agent : CharacterBodyNavigationAgent3D
var parameters : MoveToStateParams


func get_id() -> String:
    return ID


func init(params : StateParams) -> void:
    super.init(params)
    if !(params is MoveToStateParams): 
        cancel()
        return
    parameters = params


func enter() -> void:
    super.enter()
    agent.navigation_finished.connect(_on_navigation_finished)
    var success = agent.try_move_to(parameters.target_position)
    if !success:
        exit()
        return


func cancel() -> void:
    super.cancel()
    if agent.navigation_finished.is_connected(_on_navigation_finished):
        agent.navigation_finished.disconnect(_on_navigation_finished)


func exit() -> void:
    super.exit()
    if agent.navigation_finished.is_connected(_on_navigation_finished):
        agent.navigation_finished.disconnect(_on_navigation_finished)


func _on_navigation_finished() -> void:
    exit()
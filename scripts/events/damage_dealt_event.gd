class_name EventDamageDealt
extends Event

var damage_dealer: Entity
var damage_taker: Entity
var damage: int


func _init(damage_dealer, damage_taker, damage) -> void:
    self.damage_dealer = damage_dealer
    self.damage_taker = damage_taker
    self.damage = damage
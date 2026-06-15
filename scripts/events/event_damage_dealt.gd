class_name EventDamageDealt
extends Event

var damage_dealer: Entity
var damage_taker: Entity
var damage_data: DamageData


func _init(damage_dealer, damage_taker, damage_data: DamageData) -> void:
    self.damage_dealer = damage_dealer
    self.damage_taker = damage_taker
    self.damage_data = damage_data
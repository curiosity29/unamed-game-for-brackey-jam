extends Control

@onready var effect_area: Area2D = %EffectArea
@export var damage: int = 10

func execute():
    for enemy in Instance.map.get_nodes_in_group("enemy"):
        if effect_area.overlaps_area(enemy.hitbox):
            enemy.take_damage(damage)
        else:
            pass
    
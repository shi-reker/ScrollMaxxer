extends Node
class_name EffectManager

var active_effects: Array[Enums.Effect] = []
@onready var world: Main = $".."

func add_effect(new_effect: Enums.Effect):
	match(new_effect):
		Enums.Effect.MORE_ENERGY:
			world.energy = world.energy + 50
		Enums.Effect.ZERO_ENERGY:
			pass 
		Enums.Effect.TIME_STOP:
			pass 
		Enums.Effect.FINNISH_TASK:
			pass 

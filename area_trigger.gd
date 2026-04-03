extends Area3D

@export var sceneName: String = "Level 1"
@export var required_items: int = 0
var is_triggered: bool = false 

func _process(delta):

	if is_triggered:
		return
		
	var overlapping_bodies = get_overlapping_bodies()
	
	for body in overlapping_bodies:
		if body.name == "Player":
			if body.collected_cups >= required_items:
				is_triggered = true
				get_tree().change_scene_to_file("res://scenes/" + sceneName + ".tscn")

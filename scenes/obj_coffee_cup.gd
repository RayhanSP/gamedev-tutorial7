extends Area3D

# Bikin gelas muter
func _process(delta):
	rotate_y(2.0 * delta)

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		if body.has_method("collect_item"):
			body.collect_item() 
			queue_free() 

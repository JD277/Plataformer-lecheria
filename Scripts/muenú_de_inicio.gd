extends Control



func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/juego.tscn")



func _on_instructions_pressed():
	get_tree().change_scene_to_file("res://scenes/instrucciones.tscn")



func _on_about_us_pressed():
	get_tree().change_scene_to_file("res://scenes/sobre_nosotros.tscn")

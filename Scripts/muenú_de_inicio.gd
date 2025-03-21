extends Control



func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/juego.tscn")



func _on_instructions_pressed():
	$CanvasLayer.visible = true  # Muestra el Pop-Up
	reproducir_animaciones()

func _on_close_pressed():
	$CanvasLayer.visible = false  # Oculta el Pop-Up

func _on_about_us_pressed():
	get_tree().change_scene_to_file("res://scenes/sobre_nosotros.tscn")

func reproducir_animaciones():
	$CanvasLayer/AnimationPlayer.play("RESET")

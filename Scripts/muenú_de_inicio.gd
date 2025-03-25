extends Control


#muestra de transiion al iniciar el suego (cuando se presiona jugar)
func _on_start_pressed():
	# Se muestra la trancisión de salida
	$salida.visible = true
	$salida.start("desvanecer invertido")
	$stop.start()
	await $stop.timeout
	$salida.visible = false
	$salida.queue_free()

	get_tree().change_scene_to_file("res://scenes/cinematica.tscn")


#entrada a la ventana de instrucciones
func _on_instructions_pressed():
	$Instrucciones.visible = true  # Muestra el Pop-Up
	reproducir_animaciones()
	
#salida de la ventana de instrucciones
func _on_salir_intrucciones_pressed():
	$Instrucciones.visible = false  # Oculta el Pop-Up

#reprodccion de animaciones de la ventanade instrucciones
func reproducir_animaciones():
	$Instrucciones/AnimationPlayer.play("RESET")

func _on_replay_pressed():
	$Instrucciones/AnimationPlayer.play("RESET")
	
#entrada a la ventana sobre nosostros
func _on_about_us_pressed():
	$"Sobre Nosotros".visible = true
	
#salida de la ventana sobre nosotros
func _on_salir_sobre_nosotros_pressed():
	$"Sobre Nosotros".visible = false

#muetra de transicion pantalla de inicio
func _on_ready():
	
	$salida.visible = false 
	$entrada.start("desvanecer")
	$stop.start()
	await $stop.timeout
	
	# Se muestra la interfaz del juego
	$entrada.visible = false
	$entrada.queue_free()
	

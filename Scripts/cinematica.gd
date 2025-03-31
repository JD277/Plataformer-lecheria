extends Node2D


@export var historia: Array[String] # Arreglo que guardara 
@onready var nodo_texto = $texto  # Una referencia directa al nodo texto 

func _ready() -> void:
	# Se muestra la transición de entrada
	$salida.visible = false 
	$entrada.start("desvanecer")
	$stop.start()
	await $stop.timeout
	
	# Se muestra el texto de la cinematica
	$entrada.visible = false
	await mostrar_texto() 
	
	# Se muestra la trancisión de salida
	$salida.visible = true
	$salida.start("desvanecer invertido")
	$stop.start()
	await $stop.timeout
	$salida.visible = false
	get_tree().change_scene_to_file("res://scenes/juego.tscn")
	
# Muestra el texto poco a poco en la caja de texto 
func mostrar_texto():
	# Se itera frase por frase
	for texto in historia:
		# Se itera letra por letra para dar el efecto de imprenta
		for letra in texto:
			$text.start()
			nodo_texto.text = nodo_texto.text + letra
			nodo_texto.queue_redraw()
			await $text.timeout
		await esperar_input()
		nodo_texto.text = ""
	return true

# Función para esperar la entrada del jugador.
func esperar_input():
	while not Input.is_action_just_pressed("ui_accept"):
		await get_tree().physics_frame # Esperar un frame

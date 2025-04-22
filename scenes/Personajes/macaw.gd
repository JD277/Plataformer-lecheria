extends Area2D

@export var speed := 50      # Velocidad con la que el ave se mueve
@export var cambio_direccion_intervalo := 1.5   # Intervalo en segundos para cambiar de dirección
@export var altura := -50.0          # Altura en Y que el ave mantendrá respecto al jugador
@export var radio_rodeo := 100        # Radio alrededor del jugador donde el ave se moverá aleatoriamente
@export var distancia_minima := 5.0       # Distancia mínima para evitar que el ave “tiemble” al estar muy cerca

var jugador = null           # Referencia al jugador
var tiempo = 0.0             # Temporizador para cambiar de dirección
var posicion_objetivo = Vector2.ZERO            # Posición aleatoria alrededor del jugador a la que el ave se moverá
var move = true

func _ready():
	# Esperamos un par de frames para asegurarnos que el jugador ya está instanciado
	await get_tree().process_frame
	await get_tree().process_frame
	jugador = obtener_jugador()           # Intentamos obtener al jugador (buscándolo en el grupo)
	tiempo = cambio_direccion_intervalo   # Inicializamos el tiempo para la primera dirección aleatoria

func _on_body_entered(body):  #Esto hace que el ave detecte al jugador cuando el cuerpo del jugador entra en su área, y llama su función  restar_puntos()
	if body.is_in_group("jugador"):
		if body.has_method("restar_puntos"):
			body.restar_puntos(20)     # Le resta 20 puntos al jugador
			print("El ave le quitó 1 punto al jugador.")     # Mensaje de depuración
	
func _process(delta):
# Si no tenemos al jugador aún, intentamos obtenerlo
	if jugador == null:
		jugador = obtener_jugador()
		return  # No perseguimos si no hay jugador
	
	tiempo -= delta
	if move == true:
		if tiempo <= 0:
			calcular_posicion_objetivo()          # Calculamos una nueva posición objetivo aleatoria cerca del jugador
			tiempo = cambio_direccion_intervalo   # Reiniciamos el temporizador
		# Movimiento del ave hacia la posición objetivo
		var direccion = posicion_objetivo - global_position

		if direccion.length() > distancia_minima:
			global_position += direccion.normalized() * speed * delta
		# Solo se mueve si está lo suficientemente lejos, así evitamos el "temblor" cuando está muy cerca
		
		# Volteamos el sprite para que mire hacia el jugador
		if jugador != null:
			$Sprite2D.flip_h = jugador.global_position.x < global_position.x
		
	
func calcular_posicion_objetivo():
	
	if jugador == null:
		return
		
	 # Generamos un desplazamiento aleatorio en una dirección aleatoria dentro del radio de rodeo
	var offset = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * randf_range(20, radio_rodeo)
	
	# La nueva posición objetivo es la posición del jugador + ese desplazamiento + altura (más arriba en Y)
	posicion_objetivo = jugador.global_position + offset + Vector2(0, altura)

func obtener_jugador():
	var jugadores = get_tree().get_nodes_in_group("jugador")        # Busca nodos que estén en el grupo "jugador"
	if jugadores.size() > 0:
		return jugadores[0]         # Retorna el primer nodo que encuentra
	return null

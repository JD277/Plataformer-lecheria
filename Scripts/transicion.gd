extends CanvasLayer
var animacion = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start(anim):
	visible = true
	$AnimationPlayer.play(anim)
	animacion = anim

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	visible = false

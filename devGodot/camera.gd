extends Camera3D
var joueur
var offset = Vector3(10, 15, 10)
const SMOOTH = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	joueur = get_tree().get_root().find_child("joueur", true, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if joueur:
		global_position = global_position.lerp(joueur.global_position + offset, SMOOTH)
		look_at(joueur.global_position, Vector3.UP)

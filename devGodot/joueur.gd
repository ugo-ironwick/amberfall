extends CharacterBody3D
# dire à godot que ce script est pour un CharacterBody3D

# - Variables (peut les call dans des fonctions) -
var points_de_vie = 100 # vie
var ambre = 247 # Monaie
var lueurs = 8 # Énergie

# variables de déplacement
var destination = Vector3.ZERO
var nav_agent

# - Constentes (ne changent jamais) -
const SPEED = 5.2

# - S'exécute UNE FOIS au démarage -
func _ready():
	#Position de départ du déplacement
	nav_agent = $Navigation
	# affichage de la vie
	var label = $"../HUD/Stats"
	label.text = str(ambre) + " 🔅"
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not get_viewport().is_input_handled():
				deplacer_vers_clic(event.position)
		deplacer_vers_clic(event.position)
	
func deplacer_vers_clic(position_ecran: Vector2):
	var camera = $'Camera'
	var origine = camera.project_ray_origin(position_ecran)
	var direction_ray = camera.project_ray_normal(position_ecran)
	var plan_sol = Plane(Vector3.UP, 0)
	var point_sol = plan_sol.intersects_ray(origine, direction_ray)
	
	if point_sol:
		nav_agent.set_target_position(point_sol)
	
func _physics_process(_delta):
	if nav_agent.is_navigation_finished():
		return # Arrivé à destination, on s'arrête
	
	var prochaine_pos = nav_agent.get_next_path_position()
	var direction = (prochaine_pos - global_position).normalized()
	

	velocity = direction * SPEED
	move_and_slide()

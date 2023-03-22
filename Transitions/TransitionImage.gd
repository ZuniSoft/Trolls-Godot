extends Control

var transignal = Game.Transignal.new()

var _target_path : String = ""
var _target_resource : Resource = null

func _ready():
	z_index = 100
	%AnimationPlayer.play("intro")

func _on_loader_updated(_path: String, progress: float):
	if get_node("%ProgressBar") != null:
		%ProgressBar.value = progress

func _on_loader_completed(path: String, resource: Resource):
	_target_path = path
	_target_resource = resource
	%AnimationPlayer.queue("outro")

func remove_old_scene():
	transignal.remove_old_scene_requested.emit()

func set_new_scene():
	transignal.set_new_scene_requested.emit(_target_path, _target_resource)
	move_to_front()

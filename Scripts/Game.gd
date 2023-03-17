extends Node

@onready var viewport_size : Vector2 = _get_viewport_size()
@onready var screen_size : Vector2 = DisplayServer.screen_get_size()

var current_scene : Node = null

func _ready():
	get_viewport().size_changed.connect(_on_viewport_size_changed)

func _on_viewport_size_changed():
	viewport_size = _get_viewport_size()

func _get_viewport_size() -> Vector2:
	return get_viewport().get_visible_rect().size

func change_scene(path: String, use_sub_threads: bool = true, transition: String = ""):
	if transition.is_empty():
		ThreadedLoaderUtils.loader.request(path, use_sub_threads).completed.connect(_on_loader_completed)
	else:
		var scene = load(transition).instantiate()
		
		scene.transignal.remove_old_scene_requested.connect(_on_remove_old_scene_requested)
		scene.transignal.set_new_scene_requested.connect(_on_set_new_scene_requested)
		
		add_child(scene)
		
		ThreadedLoaderUtils.loader.request(path, use_sub_threads).updated.connect(Callable(scene, "_on_loader_updated"))
		ThreadedLoaderUtils.loader.request(path, use_sub_threads).completed.connect(Callable(scene, "_on_loader_completed"))

func _on_loader_completed(path: String, resource: Resource):
	remove_old_scene()
	set_new_scene(path, resource)

func remove_old_scene():
	if current_scene != null:
		current_scene.queue_free()
		current_scene = null

func set_new_scene(_path: String, resource: Resource):
	var scene = resource.instantiate()
	add_child(scene)
	current_scene = scene

func _on_change_scene_requested(path: String, use_sub_threads: bool = true, transition: String = ""):
	change_scene(path, use_sub_threads, transition)

func _on_remove_old_scene_requested():
	remove_old_scene()

func _on_set_new_scene_requested(path: String, resource: Resource):
	set_new_scene(path, resource)

class Transignal:
	signal remove_old_scene_requested()
	signal set_new_scene_requested(path: String, resource: Resource)

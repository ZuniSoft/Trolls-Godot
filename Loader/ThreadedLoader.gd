class_name ThreadedLoader

extends Node

var _queue : Dictionary = {}
var _timer : Timer = null

func set_timer(timer: Timer):
	_timer = timer
	timer.timeout.connect(_on_timer_timeout)

func get_queue() -> Dictionary:
	return _queue

func request(path: String, use_sub_threads: bool = true) -> LoadSignal:
	if _queue.has(path):
		return _queue[path]
	else:
		var load_signal = LoadSignal.new()
		_queue[path] = load_signal
		if _timer != null:
			ResourceLoader.load_threaded_request(path, "", use_sub_threads)
			if _timer.is_stopped():
				_timer.start()
			return load_signal
		else:
			return null

func _on_timer_timeout():
	if _queue.is_empty() == false:
		var remove = []
		for path in _queue:
			var array = []
			var status = ResourceLoader.load_threaded_get_status(path, array)
			var progress = float(array[0] * 100.0)
			
			_queue[path].updated.emit(path, progress)
			
			if status == ResourceLoader.THREAD_LOAD_LOADED:
				var resource = ResourceLoader.load_threaded_get(path)
				_queue[path].completed.emit(path, resource)
				remove.append(path)
			elif status != ResourceLoader.THREAD_LOAD_IN_PROGRESS:
				_queue[path].completed.emit(path, null)
				remove.append(path)
		for path in remove:
			_queue.erase(path)
	else:
		_timer.stop()

class LoadSignal:
	signal completed(path: String, resource: Resource)
	signal updated(path: String, progress: float)

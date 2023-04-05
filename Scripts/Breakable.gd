extends RigidBody2D

@export var blocks_per_side = 6
@export var blocks_impulse = 600
@export var blocks_gravity_scale = 10
@export var debris_max_time = 0.5
@export var collision_one_way = false
@export var randomize_seed = false
@export var debug_mode = false

var object = {}
	
func _ready():
	if not Globals.breakable_initialized:
		Globals.breakable_initialized = true
		
		object = {
			blocks = [],
			blocks_container = Node2D.new(),
			blocks_gravity_scale = blocks_gravity_scale,
			blocks_impulse = blocks_impulse,
			blocks_per_side = blocks_per_side,
			can_detonate = true,
			collision_extents = Vector2(),
			collision_name = null,
			collision_one_way = collision_one_way,
			collision_position = Vector2(),
			debris_max_time = debris_max_time,
			debris_timer = Timer.new(),
			detonate = false,
			frame = 0,
			height = 0,
			hframes = 1,
			offset = Vector2(),
			parent = get_parent(),
			sprite_name = null,
			vframes = 1,
			width = 0
		}
		
		# Add a unique name to 'blocks_container'.
		object.blocks_container.name = self.name + "_blocks_container"

		# Randomize the seed of the random number generator.
		if randomize_seed: randomize()

		if not self is RigidBody2D:
			print("ERROR: The '%s' node must be a 'RigidBody2D'" % self.name)
			object.can_detonate = false
			return

		for child in get_children():
			if child is Sprite2D:
				object.sprite_name = get_path_to(child)
		
			if child is CollisionShape2D:
				object.collision_name = get_path_to(child)

		if object.sprite_name.is_empty() and not object.collision_name.is_empty():
			print("ERROR: The 'RigidBody2D' (%s) must contain at least a 'Sprite' and a 'CollisionShape2D'." % self.name)
			object.can_detonate = false
			return

		if object.blocks_per_side > 10:
			print("ERROR: Too many blocks in '%s'! The maximum is 10 blocks per side." % self.name)
			object.can_detonate = false
			return

		if object.blocks_per_side % 2 != 0:
			print("ERROR: 'blocks_per_side' in '%s' must be an even number!" % self.name)
			object.can_detonate = false
			return

		# Set the debris timer.
		object.debris_timer.connect("timeout", Callable(self ,"_on_debris_timer_timeout")) 
		object.debris_timer.set_one_shot(true)
		object.debris_timer.set_wait_time(object.debris_max_time)
		object.debris_timer.name = "debris_timer"
		add_child(object.debris_timer, true)
		
		if debug_mode: print("--------------------------------")
		if debug_mode: print("Debug mode for '%s'" % self.name)
		if debug_mode: print("--------------------------------")

		# Use vframes and hframes to divide the sprite.
		get_node(object.sprite_name).vframes = object.blocks_per_side
		get_node(object.sprite_name).hframes = object.blocks_per_side
		object.vframes = get_node(object.sprite_name).vframes
		object.hframes = get_node(object.sprite_name).hframes

		if debug_mode: print("object's blocks per side: ", object.blocks_per_side)
		if debug_mode: print("object's total blocks: ", object.blocks_per_side * object.blocks_per_side)

		# Check if the sprite is using 'Region' to get the proper width and height.
		if get_node(object.sprite_name).region_enabled:
			object.width = float(get_node(object.sprite_name).region_rect.size.x)
			object.height = float(get_node(object.sprite_name).region_rect.size.y)
		else:
			object.width = float(get_node(object.sprite_name).texture.get_width())
			object.height = float(get_node(object.sprite_name).texture.get_height())

		if debug_mode: print("object's width: ", object.width)
		if debug_mode: print("object's height: ", object.height)

		# Check if the sprite is centered to get the offset.
		if get_node(object.sprite_name).centered:
			object.offset = Vector2(object.width / 2, object.height / 2)

			if debug_mode: print("object is centered!")
			if debug_mode: print("object's offset: ", object.offset)

		object.collision_extents = Vector2((object.width / 2) / object.hframes,\
											(object.height / 2) / object.vframes)

		if debug_mode: print("object's collision_extents: ", object.collision_extents)

		object.collision_position = Vector2((ceil(object.collision_extents.x) - object.collision_extents.x) * -1,\
											(ceil(object.collision_extents.y) - object.collision_extents.y) * -1)

		if debug_mode: print("object's collision_position: ", object.collision_position)

		# Set each block's properties.
		for n in range(object.vframes * object.hframes):
			# Duplicate the object.
			var duplicated_object = self.duplicate() #8
			# Add a unique name to each block.
			duplicated_object.name = self.name + "_block_" + str(n)
			# Append it to the blocks array.
			object.blocks.append(duplicated_object)

			# Create a new collision shape for each block.
			var shape = RectangleShape2D.new()
			shape.extents = object.collision_extents

			object.blocks[n].freeze_mode = FREEZE_MODE_STATIC
			object.blocks[n].get_node(object.sprite_name).vframes = object.vframes
			object.blocks[n].get_node(object.sprite_name).hframes = object.hframes
			object.blocks[n].get_node(object.sprite_name).frame = n
			object.blocks[n].get_node(object.collision_name).shape = shape
			object.blocks[n].get_node(object.collision_name).position = object.collision_position

			if object.collision_one_way: object.blocks[n].get_node(object.collision_name).one_way_collision = true
			
			if debug_mode: object.blocks[n].modulate = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 0.9)

		# Position each block in place to create the whole sprite.
		for x in range(object.hframes):
			for y in range(object.vframes):
				object.blocks[object.frame].position = Vector2(\
					y * (object.width / object.hframes) - object.offset.x + object.collision_extents.x + position.x,\
					x * (object.height / object.vframes) - object.offset.y + object.collision_extents.y + position.y)

				if debug_mode: print("object[", object.frame, "] position: ", object.blocks[object.frame].position)

				object.frame += 1

		add_children(object)
		#call_deferred("add_children", object)

		object.detonate = true
		
		if debug_mode: print("--------------------------------")
	
func _integrate_forces(state):
	explosion(state.step)

func add_children(child_object):
	for i in range(child_object.blocks.size()):
		child_object.blocks_container.add_child(child_object.blocks[i], true)

	child_object.parent.add_child(child_object.blocks_container, true)

func explosion(_delta):
	if object != {} and object.detonate:
		object.detonate = false
		
		if debug_mode: print("'%s' object exploded!" % self.name)

		for i in range(object.blocks_container.get_child_count()):
			var child = object.blocks_container.get_child(i)
			child.apply_central_impulse(Vector2(randf_range(-blocks_impulse, blocks_impulse), -blocks_impulse))
			
		object.debris_timer.start()

func _on_debris_timer_timeout():
	if object != {}:
		if debug_mode: print("'%s' object's debris timer (%ss) timed out!" % [self.name, debris_max_time])

		for i in range(object.blocks_container.get_child_count()):
			var child = object.blocks_container.get_child(i)
			child.get_node(object.collision_name).disabled = true
	
		var path = String(object.blocks_container.name)
		var node = object.parent.get_node(path)
		
		for n in node.get_children():
			node.remove_child(n)
			n.queue_free()
		
		node.free()
		
		self.queue_free()

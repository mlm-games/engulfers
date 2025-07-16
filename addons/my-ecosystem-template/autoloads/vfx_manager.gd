## Purpose: A manager for playing one-shot gameplay vfx.
## It uses an ObjectPool to efficiently manage AudioStreamPlayer instances.
## Should be added as a child to a central Utils autoload or a main scene node (or as an autoload).
class_name VFXManager extends Node

static var I : VFXManager

func _init() -> void:
	I = self

# Configuration
const INITIAL_POOL_SIZE = 15
const MAX_POOL_SIZE = 50

var _particles_pool: ObjectPool

func _ready():
	# The pool needs a scene to instantiate. Since AudioStreamPlayer is a built-in
	# type, we can't provide a .tscn file. Instead, we create a script that
	# generates the scene on the fly.
	var vfx_scene = PackedScene.new()
	vfx_scene.pack(ParticlesEmitter3D.new()) # Pack a new, empty player
	
	# Create and configure the ObjectPool as a child of this manager.
	_particles_pool = ObjectPool.new(vfx_scene, INITIAL_POOL_SIZE, MAX_POOL_SIZE)
	_particles_pool.name = "VFXPool"
	add_child(_particles_pool)

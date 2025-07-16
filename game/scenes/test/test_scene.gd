extends Control

@onready var explosion_3d: ParticlesEmitter3D = %Explosion3D

func _ready() -> void:
	explosion_3d.emit_oneshot_particles()

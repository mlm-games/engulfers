@tool
class_name ParticlesEmitter3D extends Node3D

signal finished

#@onready var particles_audio_3d: AudioStreamPlayer3D = %ParticlesAudio3D #NOTE: played in 2d
@export_tool_button("Emit Particles", "GPUParticles3D") var emitting = emit_oneshot_particles
@onready var gpu_particles_node: Node3D = %GPUParticlesNode


func emit_oneshot_particles():
	var tween = create_tween()
	for gp:GPUParticles3D in gpu_particles_node.get_children().filter(func(c): return c is GPUParticles3D):
		tween.tween_callback(gp.set_emitting.bind(true))
	
	await tween.finished
	finished.emit()
	#AudioM.play_random_sound()

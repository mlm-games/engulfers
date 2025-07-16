@tool
extends RichTextEffect
class_name RichTextVoidEntity

var bbcode = "void_entity"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var time = char_fx.elapsed_time
	var char_time = time + char_fx.relative_index * 0.1
	
	# Morphing weight effect (simulating font variation)
	var weight_cycle = sin(char_time * 2.0) * 0.3 + 1.0
	char_fx.transform = char_fx.transform.scaled(Vector2(weight_cycle, 1.0))
	
	# Void distortion per character
	var void_offset = Vector2(
		sin(char_time * 3.7) * 3.0,
		cos(char_time * 2.3) * 2.0
	)
	char_fx.offset += void_offset
	
	# Entity "phasing" effect
	var phase = (sin(char_time * 5.0) + 1.0) * 0.5
	char_fx.color = Color(0.8, 0.3, 1.0, 1.0).lerp(Color(0.1, 0.0, 0.3, 0.7), phase)
	
	# Occasional glitch spikes
	if fmod(char_time * 10.0, 7.0) < 0.1:
		char_fx.offset.y += randf_range(-10, 10)
		char_fx.transform = char_fx.transform.rotated(randf_range(-0.3, 0.3))
	
	return true

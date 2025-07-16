@tool
extends RichTextEffect
class_name RichTextVoid

# BBCode usage: [void freq=2.0 amplitude=5.0 speed=3.0]Your Title[/void]

var bbcode = "void"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var time = char_fx.elapsed_time
	var freq = char_fx.env.get("freq", 3.0)
	var amplitude = char_fx.env.get("amplitude", 5.55)
	var speed = char_fx.env.get("speed", 2.0)
	
	# distortion?
	var progress = float(char_fx.relative_index) / float(char_fx.glyph_count)
	#var wave_offset = sin(time * speed + progress * freq * TAU) * amplitude
	
	# V-floating effect
	#char_fx.offset.y = wave_offset
	
	# H-drift
	#char_fx.offset.x = sin(time * speed * 0.7 + progress * PI) * amplitude * 0.5
	
	# color shifting
	var color_shift = (sin(time * speed * 1.5 + progress * PI * 2) + 1.0) * 0.5
	var base_color = Color(0.537, 0.004, 0.919, 1.0) 
	var highlight_color = Color(0.6, 0.3, 0.8, 1.0) 
	char_fx.color = base_color.lerp(highlight_color, color_shift)
	
	# (glitchy) occasional position jumps
	#if fmod(time * speed + progress * 10, 3.0) < 0.1:
		#char_fx.offset.x += randf_range(-amplitude * 2, amplitude * 2)
		#char_fx.offset.y += randf_range(-amplitude * 2, amplitude * 2)
		#char_fx.color.a = randf_range(0.3, 1.0)
	
	# Subtle rotation for shaky effect
	char_fx.transform = char_fx.transform.rotated(sin(time * speed * 0.5 + progress * PI) * 0.01)
	
	return true

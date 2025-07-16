@tool
extends RichTextEffect
class_name RichTextFX

# BBCode: [fx preset=fire]Text[/fx] or [fx x_wave=true y_wave=true]Text[/fx]

var bbcode = "fx"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var time = char_fx.elapsed_time
	var preset = char_fx.env.get("preset", "")
	
	# Individual effect related toggles
	var x_wave = char_fx.env.get("x_wave", false)
	var y_wave = char_fx.env.get("y_wave", false)
	var scale_wave = char_fx.env.get("scale_wave", false)
	var rotate = char_fx.env.get("rotate", false)
	var rainbow = char_fx.env.get("rainbow", false)
	var fade = char_fx.env.get("fade", false)
	
	var speed = char_fx.env.get("speed", 3.0)
	var amp = char_fx.env.get("amp", 5.0)
	var freq = char_fx.env.get("freq", 2.0)
	
	var progress = float(char_fx.relative_index) / float(char_fx.glyph_count)
	var char_offset = char_fx.relative_index * 0.1
	
	match preset:
		"fire":
			y_wave = true
			rainbow = true
			speed = 5.0
			amp = 3.0
		"water":
			x_wave = true
			y_wave = true
			speed = 2.0
			amp = 4.0
		"electric":
			x_wave = true
			fade = true
			speed = 10.0
			amp = 2.0
		"magical":
			scale_wave = true
			rainbow = true
			rotate = true
			speed = 2.0
	
	if x_wave:
		char_fx.offset.x = sin(time * speed + char_offset * freq) * amp
	
	if y_wave:
		char_fx.offset.y = sin(time * speed + char_offset * freq) * amp
	
	if scale_wave:
		var scale = 1.0 + sin(time * speed + char_offset * freq) * 0.2
		char_fx.transform = char_fx.transform.scaled(Vector2(scale, scale))
	
	if rotate:
		char_fx.transform = char_fx.transform.rotated(sin(time * speed + char_offset) * 0.2)
	
	if rainbow:
		var hue = fmod(time * speed * 0.1 + progress, 1.0)
		char_fx.color = Color.from_hsv(hue, 0.8, 1.0)
	
	if fade:
		char_fx.color.a = (sin(time * speed + char_offset * freq) + 1.0) * 0.5
	
	return true

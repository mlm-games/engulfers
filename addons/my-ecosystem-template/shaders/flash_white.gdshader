shader_type canvas_item;
render_mode unshaded;

uniform sampler2D screenTexture : hint_screen_texture, filter_nearest;

uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float flash_amount : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec4 original_color = texture(screenTexture, SCREEN_UV);
	vec3 mixed_color = mix(original_color.rgb, flash_color.rgb, flash_amount);
	COLOR = vec4(mixed_color, original_color.a);
}

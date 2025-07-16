shader_type canvas_item;

uniform float wave_amplitude = 10.0;
uniform float wave_frequency = 5.0;
uniform float wave_speed = 2.0;
uniform float distortion_amount = 0.005;
uniform vec4 water_tint : source_color = vec4(0.5, 0.7, 1.0, 1.0);

void fragment() {
    vec2 uv = UV;
    
    // Wave distortion
    float wave_x = sin(uv.y * wave_frequency + TIME * wave_speed) * distortion_amount;
    float wave_y = cos(uv.x * wave_frequency + TIME * wave_speed) * distortion_amount;
    
    uv += vec2(wave_x, wave_y);
    
    vec4 tex = texture(TEXTURE, uv);
    
    // Caustics effect
    float caustics = sin(uv.x * 20.0 + TIME * 2.0) * sin(uv.y * 20.0 - TIME * 1.5);
    caustics = caustics * 0.5 + 0.5;
    
    // Tint and caustics apply
    COLOR = tex * water_tint;
    COLOR.rgb += caustics * 0.2 * tex.a;
}

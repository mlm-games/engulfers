shader_type canvas_item;

uniform sampler2D from_texture : source_color;
uniform sampler2D to_texture : source_color;
uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform float whirl_strength : hint_range(-10.0, 10.0, 0.1) = 2.0;
uniform float spiral_frequency : hint_range(1.0, 10.0, 0.1);
uniform vec2 whirl_center = vec2(0.5, 0.5);
uniform bool reverse = false;

void fragment() {
    vec2 uv = UV - whirl_center;
    //uv.x *= SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
    // Calculate distance from the whirl center
    float distance = length(uv);
    
    // Calculate effective radius based on progress
    float radius = mix(1.0, 0.0, progress);
    
    // Initialize color with the "to" texture
    vec4 color = texture(to_texture, uv);
    
    // Apply whirl effect
    if (distance < radius) {
        // Calculate the whirl amount based on distance
        float percent = (radius - distance) / radius;
        float theta = percent * percent * whirl_strength * (1.0 - progress);
        
        // Rotate the UV coordinates
        float s = sin(theta);
        float c = cos(theta);
        vec2 rotated_offset = vec2(
            uv.x * c - uv.y * s,
            uv.x * s + uv.y * c
        );
        
        // Sample the "from" texture with modified coordinates
        vec2 sample_uv = whirl_center + rotated_offset;
        sample_uv = clamp(sample_uv, vec2(0.0), vec2(1.0));
        color = texture(from_texture, sample_uv);
    }
    
    COLOR = color;
}
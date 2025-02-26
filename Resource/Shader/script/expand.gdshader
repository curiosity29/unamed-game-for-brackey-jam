shader_type canvas_item;

uniform vec2 burst_point = vec2(0.5, 0.5);
uniform vec2 min_dist_mult = vec2(-1.0, -1.0);
uniform vec2 max_dist_mult = vec2(1.0, 1.0);
uniform float duration = 1.6;
uniform float progress_value: hint_range(0.0, 1.0, 0.05);
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	//float frequency = mod(TIME/duration, 1);
	vec2 frequency_vec = vec2(progress_value, progress_value);
	vec2 offset_vector = burst_point - UV.xy;
	//vec2 min_burst_position = UV.xy - offset_vector * min_dist_mult;
	//vec2 max_burst_position = UV.xy - offset_vector * max_dist_mult;
	//vec2 current_mult = smoothstep(min_dist_mult, max_dist_mult, frequency_vec);
	vec2 current_dist_mult = mix(min_dist_mult, max_dist_mult, progress_value);
	float dist_to_center = distance(burst_point, UV.xy);
	//vec2 new_uv = smoothstep(min_burst_position, max_burst_position, frequency_vec);
	vec2 old_uv = (UV.xy + burst_point * current_dist_mult) / (current_dist_mult + 1.0);
	float alpha_mask = 1.0 - max(
		step(max_dist_mult.x * progress_value, abs(offset_vector.x)), 
		step(max_dist_mult.y * progress_value, abs(offset_vector.y))
	);
	COLOR = texture(TEXTURE, old_uv);
	COLOR.a = alpha_mask;
	// Called for every pixel the material is visible on.
}


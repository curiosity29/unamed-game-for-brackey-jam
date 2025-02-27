shader_type canvas_item;

uniform sampler2D sprite_sheet_1;
uniform int sheet_1_frames_count_int = 6;
uniform float sheet_1_fps = 20.0;

uniform sampler2D sprite_sheet_2;
uniform int sheet_2_frames_count_int = 6;
uniform float sheet_2_fps = 20.0;

uniform sampler2D sprite_sheet_3;
uniform int sheet_3_frames_count_int = 6;
uniform float sheet_3_fps = 20.0;


uniform float background_alpha = 0.15;
uniform float hue_stational_speed = 0.4;
uniform float hue_travel_speed = 0.1;


uniform vec2 movement_vector = vec2(1.0, 0.0);
uniform vec2 tile_shape = vec2(10.0, 10.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

bool is_even_pos(vec2 uv, vec2 shape) {
	return (
		(		(mod(uv.x * shape.x, 2.0) < 1.0) && (mod(uv.y * shape.y, 2.0) < 1.0)		) ||
		(		(mod(uv.x * shape.x, 2.0) > 1.0) && (mod(uv.y * shape.y, 2.0) > 1.0)		)
	);
}
vec2 to_polar(vec2 uv) {
	uv = (uv-0.5)*2.0;
	float dist = length(vec2(uv.x, uv.y));
	float angle = atan(uv.x, uv.y) / (2.0 * PI);
	return vec2(dist, angle);
}

vec3 hsv2rgb(vec3 _c) {
    vec4 _K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 _p = abs(fract(_c.xxx + _K.xyz) * 6.0 - _K.www);
    return _c.z * mix(_K.xxx, clamp(_p - _K.xxx, 0.0, 1.0), _c.y);
}

void fragment() {
	float sheet_1_frames_count = float(sheet_1_frames_count_int);
	float sheet_2_frames_count = float(sheet_2_frames_count_int);
	float sheet_3_frames_count = float(sheet_3_frames_count_int);

	float sheet_1_frequency = fract(TIME * sheet_1_fps / sheet_1_frames_count);
	float sheet_2_frequency = fract(TIME * sheet_2_fps / sheet_2_frames_count);
	float sheet_3_frequency = fract(TIME * sheet_3_fps / sheet_3_frames_count);

	float rgb_frequency = fract(TIME * hue_stational_speed);
	float movement_frequency = fract(TIME * 0.2);

	float sheet_1_frame = float(int(sheet_1_frequency * sheet_1_frames_count));
	float sheet_2_frame = float(int(sheet_2_frequency * sheet_2_frames_count));
	float sheet_3_frame = float(int(sheet_3_frequency * sheet_3_frames_count));
	//vec2 main_uv = fract(UV.xy * tiling);
	vec2 uv = UV.xy;
	vec2 moving_uv = uv + movement_vector * movement_frequency;
	vec2 polar_uv = to_polar(uv);

	vec2 tile_uv = fract(moving_uv * tile_shape);
	//vec2 main_uv = UV.xy;
	//vec2 sheet_1_uv = vec2((main_uv.x + sheet_1_frame)/sheet_1_frames_count, main_uv.y);
	vec2 sheet_uv;
	float alpha;
	if (is_even_pos(moving_uv, tile_shape)) {
		sheet_uv = vec2((tile_uv.x + sheet_1_frame)/sheet_1_frames_count, tile_uv.y);
		COLOR = texture(sprite_sheet_1, sheet_uv);
		alpha = texture(sprite_sheet_1, sheet_uv).a;
	}
	else {
		sheet_uv = vec2((tile_uv.x + sheet_2_frame)/sheet_2_frames_count, tile_uv.y);
		COLOR = texture(sprite_sheet_2, sheet_uv);
		alpha = texture(sprite_sheet_2, sheet_uv).a;
	}

	if (alpha <= 0.0) {
		COLOR = vec4(hsv2rgb(vec3(rgb_frequency - polar_uv.x * hue_travel_speed, 1.0, 1.0)), background_alpha);
	}

	vec2 sheet_3_uv = vec2((uv.x + sheet_3_frame)/sheet_3_frames_count, uv.y);
	if (texture(sprite_sheet_3, sheet_3_uv).a > 0.0) {
		COLOR.rgb = mix(COLOR.rgb, texture(sprite_sheet_3, sheet_3_uv).rgb, 0.5);
	}
	//fract(UV.xy * tiling)
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}

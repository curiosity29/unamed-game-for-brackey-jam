/*
DOOM Melting Screen-like shader!
*/
shader_type canvas_item;

uniform uint subdivisions = 10; // How many subdivisions
uniform float movement: hint_range(0.0, 2.0, 0.01); // Control for animation
uniform float noise_scale = 0.2;
uniform sampler2D noiseTexture;
// Random and noise code from godotshaders.com
//vec2 random(vec2 uv){
    //uv = vec2( dot(uv, vec2(127.1,311.7) ),
               //dot(uv, vec2(269.5,183.3) ) );
    //return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123);
//}
//
//float noise(vec2 uv) {
    //vec2 uv_index = floor(uv);
    //vec2 uv_fract = fract(uv);
//
    //return mix( mix( dot( random(uv_index + vec2(0.0,0.0) ), uv_fract - vec2(0.0,0.0) ),
                     //dot( random(uv_index + vec2(1.0,0.0) ), uv_fract - vec2(1.0,0.0) ), uv_fract.x),
                //mix( dot( random(uv_index + vec2(0.0,1.0) ), uv_fract - vec2(0.0,1.0) ),
                     //dot( random(uv_index + vec2(1.0,1.0) ), uv_fract - vec2(1.0,1.0) ), uv_fract.x), uv_fract.y) + 0.5;
//}


void fragment() {
	//float test_movement = mod(TIME, 1.0);
	//textureSize()
	// Get how much to offset based on noise
	//float offset = max(
		//noise(
			//vec2(
				//UV.x / (TEXTURE_PIXEL_SIZE.x * float(uint(textureSize(TEXTURE, 0).x) / subdivisions))
				//, 1.0)
			//), 0.0
		//);
		
	float offset = texture(noiseTexture, vec2(UV.x, 0.0) ).x;
	// 0 to 1 noise * scale
	//float pos_scaled_noise_offset = (1.0 + offset)/2.0 * noise_scale;
	float scaled_noise_offset = offset * noise_scale;
	// Offset column
	//float col = UV.y - (test_movement + offset) * test_movement;
	float col = UV.y - movement + scaled_noise_offset * movement;
	 COLOR = vec4(texture(TEXTURE, vec2(UV.x, max(col, 0))).rgb, step(0.0, col));
}

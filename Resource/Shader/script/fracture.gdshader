shader_type canvas_item;

//uniform sampler2D input_texture; // The texture to fracture
uniform vec2 eruption_point; // The point from which pieces will shoot
uniform float time : hint_range(0.0, 10.0); // Time for animation
uniform float speed : hint_range(0.0, 10.0) = 2.0; // Speed of pieces
uniform float size : hint_range(0.0, 1.0) = 0.1; // Size of the fractured pieces

// Random function to generate random values
float rand(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    // Calculate the UV coordinates for the texture
    vec2 uv = FRAGCOORD.xy / vec2(TEXTURE_PIXEL_SIZE.x * SCREEN_PIXEL_SIZE.x, TEXTURE_PIXEL_SIZE.y * SCREEN_PIXEL_SIZE.y);

    // Normalize the UV coordinates and scale them to the size of the "chunks"
    vec2 chunk_uv = floor(uv / size);
    
    // Calculate a random offset for each "piece" to give a fractured effect
    float random_offset = rand(chunk_uv);
    
    // Create a random velocity for each piece (simulate eruption)
    vec2 velocity = (eruption_point - uv) * random_offset * speed;

    // Apply the velocity to the UVs to simulate the movement of the pieces
    vec2 new_uv = uv + velocity * time;

    // Wrap the texture around the edges (if needed) to create a continuous effect
    new_uv = mod(new_uv, 1.0);

    // Sample the texture at the new UV location
    vec4 tex_color = texture(TEXTURE, new_uv);

    // Output the final color
    COLOR = tex_color;
}

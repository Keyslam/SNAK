uniform float time;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
	//texture_coords.x += .5; // shift the pixels to the left
	texture_coords.y += .2 * sin(texture_coords.x * 20.0f + time * 5.0f);
	texture_coords.y = mod(texture_coords.y, 1.);

	vec4 texturecolor = Texel(tex, texture_coords);
	return texturecolor * color;
}
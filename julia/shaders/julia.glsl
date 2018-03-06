extern float max_iterations = 200.0;
extern Image palette;
extern float ca = 0.0;
extern float cb = 0.0;


vec2 c = vec2(ca,cb);

vec2 origin = vec2(0.5,0.5);

vec2 getComplexFromCoords(vec2 coords) {
	return (coords - origin) * 4;
}

vec2 square(vec2 a) {
	return vec2(a.x*a.x - a.y*a.y, 2*a.x*a.y);
}

float length2(vec2 a) {
	return a.x*a.x + a.y*a.y;
}

vec2 getPalleteCoords(float iter) {
	float m = mod(iter,256);
	return vec2(m / 255.0,0);
}

float getAlphaFromIter(float iter) {
	return iter / max_iterations;
}

vec4 effect(vec4 setColor, Image texture, vec2 texture_coords, vec2 screen_coords) {
	vec2 z = getComplexFromCoords(texture_coords);
	bool is_in = false;
	float iterations = 0.0;
	while(true) {
		z = square(z) + c;
		if (length2(z) > 4.0) {
			break;
		} else if (iterations > max_iterations) {
			is_in = true;
			break;
		}
		iterations += 1.0;
	}
	#ifdef PALLETE_MODE
	if (is_in) {
		return vec4(0.0,0.0,0.0,1.0);
	}
	return Texel(
		palette,
		getPalleteCoords(iterations)
	);
	#endif
	return setColor * getAlphaFromIter(iterations);
	//return vec4(0.0,0.0,0.0,getAlphaFromIter(iterations));
}
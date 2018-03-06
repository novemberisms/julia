#define ITERATIONS 200

extern float ORIGINX = 0.5;
extern float ORIGINY = 0.5;
extern float SCALE = 1.0;


vec2 origin = vec2(ORIGINX, ORIGINY);
vec2 zero = vec2(0,0);

vec2 getComplexFromCoords(vec2 coords) {
	return (coords - origin)*4*SCALE;
}

vec2 square(vec2 a) {
	return vec2(a.x*a.x - a.y*a.y, 2*a.x*a.y);
}

vec4 effect(vec4 setColor, Image texture, vec2 texture_coords, vec2 pixel_coords) {
	vec2 c = getComplexFromCoords(texture_coords);
	vec2 z = zero;
	bool is_in = false;
	int iterations = 0;
	while(true) {
		z = square(z) + c;
		iterations++;
		if (length(z) > 2.0) {
			//is_in = false;	// redundant
			break;
		}
		if (iterations > ITERATIONS) {
			is_in = true;
			break;
		}
		
	}
	vec4 col = vec4(1.0,1.0,1.0,1.0);
	return is_in? vec4(0,0,0,0.5) : col;
}
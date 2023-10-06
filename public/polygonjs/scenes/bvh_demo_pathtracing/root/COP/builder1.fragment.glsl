#include <common>

uniform vec2 resolution;

// removed:
//// INSERT DEFINE



// /COP/builder1/checkers1
// https://iquilezles.org/articles/checkerfiltering/
float checkers(vec2 p) {
	vec2 s = sign(fract(p*.5)-.5);
	return .5 - .5*s.x*s.y;
}
float checkersGrad( in vec2 p, in vec2 ddx, in vec2 ddy )
{
    // filter kernel
    vec2 w = max(abs(ddx), abs(ddy)) + 0.01;
    // analytical integral (box filter)
    vec2 i = 2.0*(abs(fract((p-0.5*w)/2.0)-0.5)-abs(fract((p+0.5*w)/2.0)-0.5))/w;
    // xor pattern
    return 0.5 - 0.5*i.x*i.y;
}






void main() {

	vec4 diffuseColor = vec4(0.0,0.0,0.0,1.0);


// removed:
//	// INSERT BODY



	// /COP/builder1/constant1
	vec3 v_POLY_constant1_val = vec3(0.24313725490196078, 0.5098039215686274, 0.8549019607843137);
	
	// /COP/builder1/constant2
	vec3 v_POLY_constant2_val = vec3(0.047058823529411764, 0.10196078431372549, 0.17647058823529413);
	
	// /COP/builder1/globals1
	vec2 v_POLY_globals1_uv = vec2(gl_FragCoord.x / (resolution.x-1.), gl_FragCoord.y / (resolution.y-1.));
	
	// /COP/builder1/mult1
	vec2 v_POLY_mult1_product = (v_POLY_globals1_uv * vec2(16.0, 32.0));
	
	// /COP/builder1/checkers1
	vec2 v_POLY_checkers1_coord = v_POLY_mult1_product*vec2(1.0, 1.0)*1.0;
	float v_POLY_checkers1_checker = checkersGrad(v_POLY_checkers1_coord, dFdx(v_POLY_checkers1_coord), dFdy(v_POLY_checkers1_coord));
	
	// /COP/builder1/mix1
	vec3 v_POLY_mix1_mix = mix(v_POLY_constant1_val, v_POLY_constant2_val, v_POLY_checkers1_checker);
	
	// /COP/builder1/output1
	diffuseColor.xyz = v_POLY_mix1_mix;




	gl_FragColor = vec4( diffuseColor );
}
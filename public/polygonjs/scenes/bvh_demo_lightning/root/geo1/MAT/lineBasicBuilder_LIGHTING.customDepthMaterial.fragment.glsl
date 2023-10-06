
// INSERT DEFINES



// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/rgbToOklab1
//////////////////////////////////////////////////////////////////////
//
// Visualizing Björn Ottosson's "oklab" colorspace
//
// shadertoy implementation by mattz
//
// license CC0 (public domain)
// https://creativecommons.org/share-your-work/public-domain/cc0/
//
// Click and drag to set lightness (mouse x) and chroma (mouse y).
// Hue varies linearly across the image from left to right.
//
// While mouse is down, plotted curves show oklab components
// L (red), a (green), and b (blue). 
//
// To test the inverse mapping, the plotted curves are generated
// by mapping the (pre-clipping) linear RGB color back to oklab 
// space.
//
// White bars on top of the image (and black bars on the bottom of
// the image) indicate clipping when one or more of the R, G, B 
// components are greater than 1.0 (or less than 0.0 respectively).
//
// The color accompanying the black/white bar shows which channels
// are out of gamut.
//
// Click in the bottom left to reset the view.
//
// Hit the 'G' key to toggle displaying a gamut test:
//
//   * black pixels indicate that RGB values for some hues
//     were clipped to 0 at the given lightness/chroma pair.
//
//   * white pixels indicate that RGB values for some hues
//     were clipped to 1 at the given lightness/chroma pair
//
//   * gray pixels indicate that both types of clipping happened
//
// Hit the 'U' key to display a uniform sampling of linear sRGB 
// space, converted into oklab lightness (x position) and chroma
// (y position) coordinates. If you mouse over a colored dot, the
// spectrum on screen should include that exact color.
//
//////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
// sRGB color transform and inverse from 
// https://bottosson.github.io/posts/colorwrong/#what-can-we-do%3F

vec3 srgb_from_linear_srgb(vec3 x) {

    vec3 xlo = 12.92*x;
    vec3 xhi = 1.055 * pow(x, vec3(0.4166666666666667)) - 0.055;
    
    return mix(xlo, xhi, step(vec3(0.0031308), x));

}

vec3 linear_srgb_from_srgb(vec3 x) {

    vec3 xlo = x / 12.92;
    vec3 xhi = pow((x + 0.055)/(1.055), vec3(2.4));
    
    return mix(xlo, xhi, step(vec3(0.04045), x));

}

//////////////////////////////////////////////////////////////////////
// oklab transform and inverse from
// https://bottosson.github.io/posts/oklab/


const mat3 fwdA = mat3(1.0, 1.0, 1.0,
                       0.3963377774, -0.1055613458, -0.0894841775,
                       0.2158037573, -0.0638541728, -1.2914855480);
                       
const mat3 fwdB = mat3(4.0767245293, -1.2681437731, -0.0041119885,
                       -3.3072168827, 2.6093323231, -0.7034763098,
                       0.2307590544, -0.3411344290,  1.7068625689);

const mat3 invB = mat3(0.4121656120, 0.2118591070, 0.0883097947,
                       0.5362752080, 0.6807189584, 0.2818474174,
                       0.0514575653, 0.1074065790, 0.6302613616);
                       
const mat3 invA = mat3(0.2104542553, 1.9779984951, 0.0259040371,
                       0.7936177850, -2.4285922050, 0.7827717662,
                       -0.0040720468, 0.4505937099, -0.8086757660);

vec3 oklab_from_linear_srgb(vec3 c) {

    vec3 lms = invB * c;
            
    return invA * (sign(lms)*pow(abs(lms), vec3(0.3333333333333)));
    
}

vec3 linear_srgb_from_oklab(vec3 c) {

    vec3 lms = fwdA * c;
    
    return fwdB * (lms * lms * lms);
    
}


// https://www.shadertoy.com/view/WtccD7
const float max_chroma = 0.33;
vec3 uvToOklab(vec3 uvw){

    // setup oklab color
    float theta = 2.*3.141592653589793*uvw.x;
    
    float L = 0.8;
    float chroma = 0.1;
    
    //if (max(iMouse.x, iMouse.y) > 0.05 * iResolution.y) {
        L = uvw.y;//iMouse.x / iResolution.x;
        chroma = uvw.z * max_chroma;// / iResolution.y;
    //}
    
    float a = chroma*cos(theta);
    float b = chroma*sin(theta);
    
    vec3 lab = vec3(L, a, b);
	return lab;

    // convert to rgb 
    // vec3 rgb = linear_srgb_from_oklab(lab);

}







// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/attribute1
varying float v_POLY_attribute_id;






#if DEPTH_PACKING == 3200

	uniform float opacity;

#endif

#include <common>
#include <packing>
#include <uv_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>

varying vec2 vHighPrecisionZW;

void main() {

	#include <clipping_planes_fragment>

	vec4 diffuseColor = vec4( 1.0 );

	#if DEPTH_PACKING == 3200

		diffuseColor.a = opacity;

	#endif


	#include <map_fragment>
	#include <alphamap_fragment>

	// INSERT BODY



	// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1
	vec3 v_POLY_laserColor1_baseColor = vec3(0.0, 0.0, 0.0);
	if(true){
		// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/constant2
		vec3 v_POLY_laserColor1_constant2_val = vec3(0.6653872982754769, 0.5583403896257968, 0.005181516700061659);
	
		// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/constant1
		vec3 v_POLY_laserColor1_constant1_val = vec3(0.7011018919268015, 0.018500220124016656, 0.005181516700061659);
	
		// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/attribute1
		float v_POLY_laserColor1_attribute1_val = v_POLY_attribute_id;
	
		// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/rgbToOklab1
		vec3 v_POLY_laserColor1_rgbToOklab1_oklab = oklab_from_linear_srgb(v_POLY_laserColor1_constant2_val);
	
		// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/rgbToOklab2
		vec3 v_POLY_laserColor1_rgbToOklab2_oklab = oklab_from_linear_srgb(v_POLY_laserColor1_constant1_val);
	
		// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/round1
		float v_POLY_laserColor1_round1_val = sign(v_POLY_laserColor1_attribute1_val)*floor(abs(v_POLY_laserColor1_attribute1_val)+0.5);
	
		// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/floatToVec2_1
		vec2 v_POLY_laserColor1_floatToVec2_1_vec2 = vec2(v_POLY_laserColor1_round1_val, 0.54);
	
		// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/random1
		float v_POLY_laserColor1_random1_rand = rand(v_POLY_laserColor1_floatToVec2_1_vec2);
	
		// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/pow1
		float v_POLY_laserColor1_pow1_val = pow(v_POLY_laserColor1_random1_rand, 0.27);
	
		// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/mix1
		vec3 v_POLY_laserColor1_mix1_mix = mix(v_POLY_laserColor1_rgbToOklab1_oklab, v_POLY_laserColor1_rgbToOklab2_oklab, v_POLY_laserColor1_pow1_val);
	
		// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/oklabToRgb1
		vec3 v_POLY_laserColor1_oklabToRgb1_rgb = linear_srgb_from_oklab(v_POLY_laserColor1_mix1_mix);
	
		// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/subnetOutput1
		v_POLY_laserColor1_baseColor = v_POLY_laserColor1_oklabToRgb1_rgb;
	}
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/constant3
	float v_POLY_constant3_val = 0.86;
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/multScalar2
	vec3 v_POLY_multScalar2_val = (6.0*v_POLY_laserColor1_baseColor);
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/output1
	diffuseColor.xyz = v_POLY_multScalar2_val;
	diffuseColor.w = v_POLY_constant3_val;



	// the new body lines should be added before the alphatest_fragment
	// so that alpha is set before (which is really how it would be set if the alphamap_fragment above was used by the material node parameters)

	#include <alphatest_fragment>

	#include <logdepthbuf_fragment>


	// Higher precision equivalent of gl_FragCoord.z. This assumes depthRange has been left to its default values.
	float fragCoordZ = 0.5 * vHighPrecisionZW[0] / vHighPrecisionZW[1] + 0.5;

	#if DEPTH_PACKING == 3200

		gl_FragColor = vec4( vec3( 1.0 - fragCoordZ ), diffuseColor.a );

	#elif DEPTH_PACKING == 3201

		gl_FragColor = packDepthToRGBA( fragCoordZ );

	#endif

}

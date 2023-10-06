uniform float scale;
attribute float lineDistance;
varying float vLineDistance;
#include <common>



// /geo1/MAT/lineBasicBuilder_LIGHTING/noise1
// Modulo 289 without a division (only multiplications)
float mod289(float x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}
vec2 mod289(vec2 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}
vec3 mod289(vec3 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}
vec4 mod289(vec4 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}
// Modulo 7 without a division
vec3 mod7(vec3 x) {
  return x - floor(x * (1.0 / 7.0)) * 7.0;
}

// Permutation polynomial: (34x^2 + x) mod 289
float permute(float x) {
     return mod289(((x*34.0)+1.0)*x);
}
vec3 permute(vec3 x) {
  return mod289((34.0 * x + 1.0) * x);
}
vec4 permute(vec4 x) {
     return mod289(((x*34.0)+1.0)*x);
}

float taylorInvSqrt(float r)
{
  return 1.79284291400159 - 0.85373472095314 * r;
}
vec4 taylorInvSqrt(vec4 r)
{
  return 1.79284291400159 - 0.85373472095314 * r;
}

vec2 fade(vec2 t) {
  return t*t*t*(t*(t*6.0-15.0)+10.0);
}
vec3 fade(vec3 t) {
  return t*t*t*(t*(t*6.0-15.0)+10.0);
}
vec4 fade(vec4 t) {
  return t*t*t*(t*(t*6.0-15.0)+10.0);
}
//
// Description : Array and textureless GLSL 2D/3D/4D simplex 
//               noise functions.
//      Author : Ian McEwan, Ashima Arts.
//  Maintainer : stegu
//     Lastmod : 20110822 (ijm)
//     License : Copyright (C) 2011 Ashima Arts. All rights reserved.
//               Distributed under the MIT License. See LICENSE file.
//               https://github.com/ashima/webgl-noise
//               https://github.com/stegu/webgl-noise
// 



float snoise(vec3 v)
  { 
  const vec2  C = vec2(1.0/6.0, 1.0/3.0) ;
  const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);

// First corner
  vec3 i  = floor(v + dot(v, C.yyy) );
  vec3 x0 =   v - i + dot(i, C.xxx) ;

// Other corners
  vec3 g = step(x0.yzx, x0.xyz);
  vec3 l = 1.0 - g;
  vec3 i1 = min( g.xyz, l.zxy );
  vec3 i2 = max( g.xyz, l.zxy );

  //   x0 = x0 - 0.0 + 0.0 * C.xxx;
  //   x1 = x0 - i1  + 1.0 * C.xxx;
  //   x2 = x0 - i2  + 2.0 * C.xxx;
  //   x3 = x0 - 1.0 + 3.0 * C.xxx;
  vec3 x1 = x0 - i1 + C.xxx;
  vec3 x2 = x0 - i2 + C.yyy; // 2.0*C.x = 1/3 = C.y
  vec3 x3 = x0 - D.yyy;      // -1.0+3.0*C.x = -0.5 = -D.y

// Permutations
  i = mod289(i); 
  vec4 p = permute( permute( permute( 
             i.z + vec4(0.0, i1.z, i2.z, 1.0 ))
           + i.y + vec4(0.0, i1.y, i2.y, 1.0 )) 
           + i.x + vec4(0.0, i1.x, i2.x, 1.0 ));

// Gradients: 7x7 points over a square, mapped onto an octahedron.
// The ring size 17*17 = 289 is close to a multiple of 49 (49*6 = 294)
  float n_ = 0.142857142857; // 1.0/7.0
  vec3  ns = n_ * D.wyz - D.xzx;

  vec4 j = p - 49.0 * floor(p * ns.z * ns.z);  //  mod(p,7*7)

  vec4 x_ = floor(j * ns.z);
  vec4 y_ = floor(j - 7.0 * x_ );    // mod(j,N)

  vec4 x = x_ *ns.x + ns.yyyy;
  vec4 y = y_ *ns.x + ns.yyyy;
  vec4 h = 1.0 - abs(x) - abs(y);

  vec4 b0 = vec4( x.xy, y.xy );
  vec4 b1 = vec4( x.zw, y.zw );

  //vec4 s0 = vec4(lessThan(b0,0.0))*2.0 - 1.0;
  //vec4 s1 = vec4(lessThan(b1,0.0))*2.0 - 1.0;
  vec4 s0 = floor(b0)*2.0 + 1.0;
  vec4 s1 = floor(b1)*2.0 + 1.0;
  vec4 sh = -step(h, vec4(0.0));

  vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
  vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;

  vec3 p0 = vec3(a0.xy,h.x);
  vec3 p1 = vec3(a0.zw,h.y);
  vec3 p2 = vec3(a1.xy,h.z);
  vec3 p3 = vec3(a1.zw,h.w);

//Normalise gradients
  vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;

// Mix final noise value
  vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
  m = m * m;
  return 42.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1), 
                                dot(p2,x2), dot(p3,x3) ) );
  }


float fbm_snoise_geo1_MAT_lineBasicBuilder_LIGHTING_noise1(in vec3 st) {
	float value = 0.0;
	float amplitude = 1.0;
	for (int i = 0; i < 6; i++) {
		value += amplitude * snoise(st);
		st *= 2.0;
		amplitude *= 0.5;
	}
	return value;
}








// /geo1/MAT/lineBasicBuilder_LIGHTING/param1
uniform vec3 v_POLY_param_destPos;

// /geo1/MAT/lineBasicBuilder_LIGHTING/globals2
uniform float time;

// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1/attribute1
varying float v_POLY_attribute_id;

// /geo1/MAT/lineBasicBuilder_LIGHTING/attribute1
attribute float idn;

// /geo1/MAT/lineBasicBuilder_LIGHTING/attribute2
attribute float id;




#include <uv_pars_vertex>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <morphtarget_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>
void main() {
	vLineDistance = scale * lineDistance;
	#include <uv_vertex>
	#include <color_vertex>



	// /geo1/MAT/lineBasicBuilder_LIGHTING/constant1
	vec3 v_POLY_constant1_val = vec3(0.0, 0.0, 0.0);
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/param1
	vec3 v_POLY_param1_val = v_POLY_param_destPos;
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/attribute1
	float v_POLY_attribute1_val = idn;
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/attribute2
	float v_POLY_attribute2_val = id;
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/globals2
	float v_POLY_globals2_time = time;
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/laserColor1
	float v_POLY_laserColor1_attribute1_val = id;
	v_POLY_attribute_id = float(id);
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/mix1
	vec3 v_POLY_mix1_mix = mix(v_POLY_constant1_val, v_POLY_param1_val, v_POLY_attribute1_val);
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/smoothstep1
	float v_POLY_smoothstep1_val = smoothstep(0.0, 0.1, v_POLY_attribute1_val);
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/smoothstep2
	float v_POLY_smoothstep2_val = smoothstep(1.0, 0.83, v_POLY_attribute1_val);
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/multAdd3
	float v_POLY_multAdd3_val = (-1.0*(v_POLY_globals2_time + 0.0)) + 0.0;
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/multAdd1
	float v_POLY_multAdd1_val = (0.79*(v_POLY_globals2_time + 0.0)) + 0.0;
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/min1
	float v_POLY_min1_val = min(v_POLY_smoothstep1_val, v_POLY_smoothstep2_val);
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/multAdd2
	float v_POLY_multAdd2_val = (1.0*(v_POLY_attribute1_val + 0.0)) + v_POLY_multAdd3_val;
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/floatToVec3_2
	vec3 v_POLY_floatToVec3_2_vec3 = vec3(0.0, v_POLY_multAdd1_val, 0.21);
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/floatToVec3_1
	vec3 v_POLY_floatToVec3_1_vec3 = vec3(v_POLY_min1_val, v_POLY_min1_val, v_POLY_min1_val);
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/floatToVec3_3
	vec3 v_POLY_floatToVec3_3_vec3 = vec3(0.0, v_POLY_attribute2_val, v_POLY_multAdd2_val);
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/multScalar1
	vec3 v_POLY_multScalar1_val = (0.42*v_POLY_floatToVec3_1_vec3);
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/noise1
	float v_POLY_noise1_noisex = (v_POLY_multScalar1_val*fbm_snoise_geo1_MAT_lineBasicBuilder_LIGHTING_noise1((v_POLY_floatToVec3_3_vec3*vec3(1.0, 1.0, 1.0))+(v_POLY_floatToVec3_2_vec3+vec3(0.0, 0.0, 0.0)))).x;
	float v_POLY_noise1_noisey = (v_POLY_multScalar1_val*fbm_snoise_geo1_MAT_lineBasicBuilder_LIGHTING_noise1((v_POLY_floatToVec3_3_vec3*vec3(1.0, 1.0, 1.0))+(v_POLY_floatToVec3_2_vec3+vec3(1000.0, 1000.0, 1000.0)))).y;
	float v_POLY_noise1_noisez = (v_POLY_multScalar1_val*fbm_snoise_geo1_MAT_lineBasicBuilder_LIGHTING_noise1((v_POLY_floatToVec3_3_vec3*vec3(1.0, 1.0, 1.0))+(v_POLY_floatToVec3_2_vec3+vec3(2000.0, 2000.0, 2000.0)))).z;
	vec3 v_POLY_noise1_noise = vec3(v_POLY_noise1_noisex, v_POLY_noise1_noisey, v_POLY_noise1_noisez);
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/add1
	vec3 v_POLY_add1_sum = (v_POLY_mix1_mix + v_POLY_noise1_noise + vec3(0.0, 0.0, 0.0));
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/max1
	vec3 v_POLY_max1_val = max(v_POLY_add1_sum, vec3(-1000.0, 0.0, -1000.0));
	
	// /geo1/MAT/lineBasicBuilder_LIGHTING/output1
	vec3 transformed = v_POLY_max1_val;vec4 mvPosition = vec4( transformed, 1.0 ); gl_Position = projectionMatrix * modelViewMatrix * mvPosition;



	#include <morphcolor_vertex>
// removed:
//	#include <begin_vertex>
	#include <morphtarget_vertex>
// removed:
//	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	#include <fog_vertex>
}
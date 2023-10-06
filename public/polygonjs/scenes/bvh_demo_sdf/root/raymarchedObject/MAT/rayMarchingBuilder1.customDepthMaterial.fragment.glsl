precision highp float;
precision highp int;

// --- applyMaterial constants definition
uniform int MAX_STEPS;
uniform float MAX_DIST;
uniform float SURF_DIST;
uniform float NORMALS_BIAS;
uniform float SHADOW_BIAS;
#define ZERO 0
uniform float debugMinSteps;
uniform float debugMaxSteps;
uniform float debugMinDepth;
uniform float debugMaxDepth;

#include <common>
#include <packing>
#include <lightmap_pars_fragment>
#include <bsdfs>
#include <cube_uv_reflection_fragment>
#include <lights_pars_begin>
#include <lights_physical_pars_fragment>
#include <shadowmap_pars_fragment>
#include <fog_pars_fragment>

#if defined( SHADOW_DISTANCE )
	uniform float shadowDistanceMin;
	uniform float shadowDistanceMax;
#endif 
#if defined( SHADOW_DEPTH )
	uniform float shadowDepthMin;
	uniform float shadowDepthMax;
#endif

// varying vec2 vHighPrecisionZW;

varying vec3 vPw;
varying mat4 vModelMatrix;
varying mat4 vInverseModelMatrix;
varying mat4 VViewMatrix;

#if NUM_SPOT_LIGHTS > 0
	struct SpotLightRayMarching {
		float penumbra;
		float shadowBiasAngle;
		float shadowBiasDistance;
	};
	uniform SpotLightRayMarching spotLightsRayMarching[ NUM_SPOT_LIGHTS ];
	#if NUM_SPOT_LIGHT_COORDS > 0

		uniform mat4 spotLightMatrix[ NUM_SPOT_LIGHT_COORDS ];

	#endif
#endif
#if NUM_DIR_LIGHTS > 0
	struct DirectionalLightRayMarching {
		float penumbra;
		float shadowBiasAngle;
		float shadowBiasDistance;
	};
	uniform DirectionalLightRayMarching directionalLightsRayMarching[ NUM_DIR_LIGHTS ];
	#if NUM_DIR_LIGHT_SHADOWS > 0

		uniform mat4 directionalShadowMatrix[ NUM_DIR_LIGHT_SHADOWS ];

	#endif
#endif
#if NUM_POINT_LIGHTS > 0
	struct PointLightRayMarching {
		float penumbra;
		float shadowBiasAngle;
		float shadowBiasDistance;
	};
	uniform PointLightRayMarching pointLightsRayMarching[ NUM_POINT_LIGHTS ];
	#if NUM_POINT_LIGHT_SHADOWS > 0

		uniform mat4 pointShadowMatrix[ NUM_POINT_LIGHT_SHADOWS ];

	#endif
#endif


struct SDFContext {
	float d;
	int stepsCount;
	int matId;
	int matId2;
	float matBlend;
};

SDFContext DefaultSDFContext(){
	return SDFContext( 0., 0, 0, 0, 0. );
}
int DefaultSDFMaterial(){
	return 0;
}

// start raymarching builder define code



// /raymarchedObject/MAT/rayMarchingBuilder1/textureSDF1
float dot2( in vec2 v ) { return dot(v,v); }
float dot2( in vec3 v ) { return dot(v,v); }
float ndot( in vec2 a, in vec2 b ) { return a.x*b.x - a.y*b.y; }
// https://iquilezles.org/articles/distfunctions/


/*
*
* SDF PRIMITIVES
*
*/
float sdSphere( vec3 p, float s )
{
	return length(p)-s;
}
float sdCutSphere( vec3 p, float r, float h )
{
	// sampling independent computations (only depend on shape)
	float w = sqrt(r*r-h*h);

	// sampling dependant computations
	vec2 q = vec2( length(p.xz), p.y );
	float s = max( (h-r)*q.x*q.x+w*w*(h+r-2.0*q.y), h*q.x-w*q.y );
	return (s<0.0) ? length(q)-r :
				(q.x<w) ? h - q.y :
					length(q-vec2(w,h));
}
float sdCutHollowSphere( vec3 p, float r, float h, float t )
{
	// sampling independent computations (only depend on shape)
	float w = sqrt(r*r-h*h);
	
	// sampling dependant computations
	vec2 q = vec2( length(p.xz), p.y );
	return ((h*q.x<w*q.y) ? length(q-vec2(w,h)) : 
							abs(length(q)-r) ) - t;
}

float sdBox( vec3 p, vec3 b )
{
	vec3 q = abs(p) - b*0.5;
	return length(max(q,0.0)) + min(max(q.x,max(q.y,q.z)),0.0);
}
float sdRoundBox( vec3 p, vec3 b, float r )
{
	vec3 q = abs(p) - b*0.5;
	return length(max(q,0.0)) + min(max(q.x,max(q.y,q.z)),0.0) - r;
}


float sdBoxFrame( vec3 p, vec3 b, float e )
{
		p = abs(p  )-b*0.5;
	vec3 q = abs(p+e)-e;
	return min(min(
		length(max(vec3(p.x,q.y,q.z),0.0))+min(max(p.x,max(q.y,q.z)),0.0),
		length(max(vec3(q.x,p.y,q.z),0.0))+min(max(q.x,max(p.y,q.z)),0.0)),
		length(max(vec3(q.x,q.y,p.z),0.0))+min(max(q.x,max(q.y,p.z)),0.0));
}
float sdCapsule( vec3 p, vec3 a, vec3 b, float r )
{
	vec3 pa = p - a, ba = b - a;
	float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
	return length( pa - ba*h ) - r;
}
float sdVerticalCapsule( vec3 p, float h, float r )
{
	p.y -= clamp( p.y, 0.0, h );
	return length( p ) - r;
}
float sdCone( in vec3 p, in vec2 c, float h )
{
	// c is the sin/cos of the angle, h is height
	// Alternatively pass q instead of (c,h),
	// which is the point at the base in 2D
	vec2 q = h*vec2(c.x/c.y,-1.0);

	vec2 w = vec2( length(p.xz), p.y );
	vec2 a = w - q*clamp( dot(w,q)/dot(q,q), 0.0, 1.0 );
	vec2 b = w - q*vec2( clamp( w.x/q.x, 0.0, 1.0 ), 1.0 );
	float k = sign( q.y );
	float d = min(dot( a, a ),dot(b, b));
	float s = max( k*(w.x*q.y-w.y*q.x),k*(w.y-q.y)  );
	return sqrt(d)*sign(s);
}
float sdConeWrapped(vec3 pos, float angle, float height){
	return sdCone(pos, vec2(sin(angle), cos(angle)), height);
}
float sdRoundCone( vec3 p, float r1, float r2, float h )
{
	float b = (r1-r2)/h;
	float a = sqrt(1.0-b*b);

	vec2 q = vec2( length(p.xz), p.y );
	float k = dot(q,vec2(-b,a));
	if( k<0.0 ) return length(q) - r1;
	if( k>a*h ) return length(q-vec2(0.0,h)) - r2;
	return dot(q, vec2(a,b) ) - r1;
}
float sdOctogonPrism( in vec3 p, in float r, float h )
{
	const vec3 k = vec3(-0.9238795325,  // sqrt(2+sqrt(2))/2 
						0.3826834323,   // sqrt(2-sqrt(2))/2
						0.4142135623 ); // sqrt(2)-1 
	// reflections
	p = abs(p);
	p.xy -= 2.0*min(dot(vec2( k.x,k.y),p.xy),0.0)*vec2( k.x,k.y);
	p.xy -= 2.0*min(dot(vec2(-k.x,k.y),p.xy),0.0)*vec2(-k.x,k.y);
	// polygon side
	p.xy -= vec2(clamp(p.x, -k.z*r, k.z*r), r);
	vec2 d = vec2( length(p.xy)*sign(p.y), p.z-h );
	return min(max(d.x,d.y),0.0) + length(max(d,0.0));
}
float sdHexPrism( vec3 p, vec2 h )
{
	const vec3 k = vec3(-0.8660254, 0.5, 0.57735);
	p = abs(p);
	p.xy -= 2.0*min(dot(k.xy, p.xy), 0.0)*k.xy;
	vec2 d = vec2(
		length(p.xy-vec2(clamp(p.x,-k.z*h.x,k.z*h.x), h.x))*sign(p.y-h.x),
		p.z-h.y );
	return min(max(d.x,d.y),0.0) + length(max(d,0.0));
}
float sdHorseshoe( in vec3 p, in float angle, in float r, in float le, vec2 w )
{
	vec2 c = vec2(cos(angle),sin(angle));
	p.x = abs(p.x);
	float l = length(p.xy);
	p.xy = mat2(-c.x, c.y, 
			c.y, c.x)*p.xy;
	p.xy = vec2((p.y>0.0 || p.x>0.0)?p.x:l*sign(-c.x),
				(p.x>0.0)?p.y:l );
	p.xy = vec2(p.x,abs(p.y-r))-vec2(le,0.0);
	
	vec2 q = vec2(length(max(p.xy,0.0)) + min(0.0,max(p.x,p.y)),p.z);
	vec2 d = abs(q) - w;
	return min(max(d.x,d.y),0.0) + length(max(d,0.0));
}
float sdTriPrism( vec3 p, vec2 h )
{
	vec3 q = abs(p);
	return max(q.z-h.y,max(q.x*0.866025+p.y*0.5,-p.y)-h.x*0.5);
}
float sdPyramid( vec3 p, float h)
{
	float m2 = h*h + 0.25;

	p.xz = abs(p.xz);
	p.xz = (p.z>p.x) ? p.zx : p.xz;
	p.xz -= 0.5;

	vec3 q = vec3( p.z, h*p.y - 0.5*p.x, h*p.x + 0.5*p.y);

	float s = max(-q.x,0.0);
	float t = clamp( (q.y-0.5*p.z)/(m2+0.25), 0.0, 1.0 );

	float a = m2*(q.x+s)*(q.x+s) + q.y*q.y;
	float b = m2*(q.x+0.5*t)*(q.x+0.5*t) + (q.y-m2*t)*(q.y-m2*t);

	float d2 = min(q.y,-q.x*m2-q.y*0.5) > 0.0 ? 0.0 : min(a,b);

	return sqrt( (d2+q.z*q.z)/m2 ) * sign(max(q.z,-p.y));
}

float sdPlane( vec3 p, vec3 n, float h )
{
	// n must be normalized
	return dot(p,n) + h;
}

float sdTorus( vec3 p, vec2 t )
{
	vec2 q = vec2(length(p.xz)-t.x,p.y);
	return length(q)-t.y;
}
float sdCappedTorus(in vec3 p, in float an, in float ra, in float rb)
{
	vec2 sc = vec2(sin(an),cos(an));
	p.x = abs(p.x);
	float k = (sc.y*p.x>sc.x*p.z) ? dot(p.xz,sc) : length(p.xz);
	return sqrt( dot(p,p) + ra*ra - 2.0*ra*k ) - rb;
}
float sdLink( vec3 p, float le, float r1, float r2 )
{
  vec3 q = vec3( p.x, max(abs(p.y)-le,0.0), p.z );
  return length(vec2(length(q.xy)-r1,q.z)) - r2;
}
// c is the sin/cos of the desired cone angle
float sdSolidAngle(vec3 pos, vec2 c, float radius)
{
	vec2 p = vec2( length(pos.xz), pos.y );
	float l = length(p) - radius;
	float m = length(p - c*clamp(dot(p,c),0.0,radius) );
	return max(l,m*sign(c.y*p.x-c.x*p.y));
}
float sdSolidAngleWrapped(vec3 pos, float angle, float radius){
	return sdSolidAngle(pos, vec2(sin(angle), cos(angle)), radius);
}
float sdTube( vec3 p, float r )
{
	return length(p.xz)-r;
}
float sdTubeCapped( vec3 p, float h, float r )
{
	vec2 d = abs(vec2(length(p.xz),p.y)) - vec2(r,h);
	return min(max(d.x,d.y),0.0) + length(max(d,0.0));
}
float sdOctahedron( vec3 p, float s)
{
  p = abs(p);
  float m = p.x+p.y+p.z-s;
  vec3 q;
       if( 3.0*p.x < m ) q = p.xyz;
  else if( 3.0*p.y < m ) q = p.yzx;
  else if( 3.0*p.z < m ) q = p.zxy;
  else return m*0.57735027;
    
  float k = clamp(0.5*(q.z-q.y+s),0.0,s); 
  return length(vec3(q.x,q.y-s+k,q.z-k)); 
}
float udTriangle( vec3 p, vec3 a, vec3 b, vec3 c, float thickness )
{
	vec3 ba = b - a; vec3 pa = p - a;
	vec3 cb = c - b; vec3 pb = p - b;
	vec3 ac = a - c; vec3 pc = p - c;
	vec3 nor = cross( ba, ac );

	return - thickness + sqrt(
		(sign(dot(cross(ba,nor),pa)) +
		sign(dot(cross(cb,nor),pb)) +
		sign(dot(cross(ac,nor),pc))<2.0)
		?
		min( min(
		dot2(ba*clamp(dot(ba,pa)/dot2(ba),0.0,1.0)-pa),
		dot2(cb*clamp(dot(cb,pb)/dot2(cb),0.0,1.0)-pb) ),
		dot2(ac*clamp(dot(ac,pc)/dot2(ac),0.0,1.0)-pc) )
		:
		dot(nor,pa)*dot(nor,pa)/dot2(nor) );
}
float udQuad( vec3 p, vec3 a, vec3 b, vec3 c, vec3 d, float thickness )
{
	vec3 ba = b - a; vec3 pa = p - a;
	vec3 cb = c - b; vec3 pb = p - b;
	vec3 dc = d - c; vec3 pc = p - c;
	vec3 ad = a - d; vec3 pd = p - d;
	vec3 nor = cross( ba, ad );

	return - thickness + sqrt(
		(sign(dot(cross(ba,nor),pa)) +
		sign(dot(cross(cb,nor),pb)) +
		sign(dot(cross(dc,nor),pc)) +
		sign(dot(cross(ad,nor),pd))<3.0)
		?
		min( min( min(
		dot2(ba*clamp(dot(ba,pa)/dot2(ba),0.0,1.0)-pa),
		dot2(cb*clamp(dot(cb,pb)/dot2(cb),0.0,1.0)-pb) ),
		dot2(dc*clamp(dot(dc,pc)/dot2(dc),0.0,1.0)-pc) ),
		dot2(ad*clamp(dot(ad,pd)/dot2(ad),0.0,1.0)-pd) )
		:
		dot(nor,pa)*dot(nor,pa)/dot2(nor) );
}

/*
*
* SDF OPERATIONS
*
*/
float SDFUnion( float d1, float d2 ) { return min(d1,d2); }
float SDFSubtract( float d1, float d2 ) { return max(-d1,d2); }
float SDFIntersect( float d1, float d2 ) { return max(d1,d2); }

float SDFSmoothUnion( float d1, float d2, float k ) {
	float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
	return mix( d2, d1, h ) - k*h*(1.0-h);
}

float SDFSmoothSubtract( float d1, float d2, float k ) {
	float h = clamp( 0.5 - 0.5*(d2+d1)/k, 0.0, 1.0 );
	return mix( d2, -d1, h ) + k*h*(1.0-h);
}

float SDFSmoothIntersect( float d1, float d2, float k ) {
	float h = clamp( 0.5 - 0.5*(d2-d1)/k, 0.0, 1.0 );
	return mix( d2, d1, h ) + k*h*(1.0-h);
}

vec4 SDFElongateFast( in vec3 p, in vec3 h )
{
	return vec4( p-clamp(p,-h,h), 0.0 );
}
vec4 SDFElongateSlow( in vec3 p, in vec3 h )
{
	vec3 q = abs(p)-h;
	return vec4( max(q,0.0), min(max(q.x,max(q.y,q.z)),0.0) );
}

float SDFOnion( in float sdf, in float thickness )
{
	return abs(sdf)-thickness;
}

// /raymarchedObject/MAT/rayMarchingBuilder1/cycle1
float cycle(float val, float val_min, float val_max){
	if(val >= val_min && val < val_max){
		return val;
	} else {
		float range = val_max - val_min;
		if(val >= val_max){
			float delta = (val - val_max);
			return val_min + mod(delta, range);
		} else {
			float delta = (val_min - val);
			return val_max - mod(delta, range);
		}
	}
}

// /raymarchedObject/MAT/rayMarchingBuilder1/SDFMaterial1
const int _RAYMARCHEDOBJECT_MAT_RAYMARCHINGBUILDER1_SDFMATERIAL1 = 1;


// https://stackoverflow.com/questions/23793698/how-to-implement-slerp-in-glsl-hlsl
// vec4 quatSlerp(vec4 p0, vec4 p1, float t)
// {
// 	float dotp = dot(normalize(p0), normalize(p1));
// 	if ((dotp > 0.9999) || (dotp < -0.9999))
// 	{
// 		if (t<=0.5)
// 			return p0;
// 		return p1;
// 	}
// 	float theta = acos(dotp);
// 	vec4 P = ((p0*sin((1.0-t)*theta) + p1*sin(t*theta)) / sin(theta));
// 	P.w = 1.0;
// 	return P;
// }

// https://devcry.heiho.net/html/2017/20170521-slerp.html
// float lerp(float a, float b, float t) {
// 	return (1.0 - t) * a + t * b;
// }
// vec4 quatSlerp(vec4 p0, vec4 p1, float t){
// 	vec4 qb = p1;

// 	// cos(a) = dot product
// 	float cos_a = p0.x * qb.x + p0.y * qb.y + p0.z * qb.z + p0.w * qb.w;
// 	if (cos_a < 0.0f) {
// 		cos_a = -cos_a;
// 		qb = -qb;
// 	}

// 	// close to zero, cos(a) ~= 1
// 	// do linear interpolation
// 	if (cos_a > 0.999) {
// 		return vec4(
// 			lerp(p0.x, qb.x, t),
// 			lerp(p0.y, qb.y, t),
// 			lerp(p0.z, qb.z, t),
// 			lerp(p0.w, qb.w, t)
// 		);
// 	}

// 	float alpha = acos(cos_a);
// 	return (p0 * sin(1.0 - t) + p1 * sin(t * alpha)) / sin(alpha);
// }

// https://stackoverflow.com/questions/62943083/interpolate-between-two-quaternions-the-long-way
vec4 quatSlerp(vec4 q1, vec4 q2, float t){
	float angle = acos(dot(q1, q2));
	float denom = sin(angle);
	//check if denom is zero
	return (q1*sin((1.0-t)*angle)+q2*sin(t*angle))/denom;
}
// TO CHECK:
// this page https://www.reddit.com/r/opengl/comments/704la7/glsl_quaternion_library/
// has a link to a potentially nice pdf:
// http://web.mit.edu/2.998/www/QuaternionReport1.pdf

// https://github.com/mattatz/ShibuyaCrowd/blob/master/source/shaders/common/quaternion.glsl
vec4 quatMult(vec4 q1, vec4 q2)
{
	return vec4(
	q1.w * q2.x + q1.x * q2.w + q1.z * q2.y - q1.y * q2.z,
	q1.w * q2.y + q1.y * q2.w + q1.x * q2.z - q1.z * q2.x,
	q1.w * q2.z + q1.z * q2.w + q1.y * q2.x - q1.x * q2.y,
	q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z
	);
}
// http://glmatrix.net/docs/quat.js.html#line97
//   let ax = a[0], ay = a[1], az = a[2], aw = a[3];

//   let bx = b[0], by = b[1], bz = b[2], bw = b[3];

//   out[0] = ax * bw + aw * bx + ay * bz - az * by;

//   out[1] = ay * bw + aw * by + az * bx - ax * bz;

//   out[2] = az * bw + aw * bz + ax * by - ay * bx;

//   out[3] = aw * bw - ax * bx - ay * by - az * bz;

//   return out



// http://www.neilmendoza.com/glsl-rotation-about-an-arbitrary-axis/
mat4 rotationMatrix(vec3 axis, float angle)
{
	axis = normalize(axis);
	float s = sin(angle);
	float c = cos(angle);
	float oc = 1.0 - c;

 	return mat4(oc * axis.x * axis.x + c, oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s, 0.0, oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c, oc * axis.y * axis.z - axis.x * s,  0.0, oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c, 0.0, 0.0, 0.0, 0.0, 1.0);
}

// https://www.geeks3d.com/20141201/how-to-rotate-a-vertex-by-a-quaternion-in-glsl/
vec4 quatFromAxisAngle(vec3 axis, float angle)
{
	vec4 qr;
	float half_angle = (angle * 0.5); // * 3.14159 / 180.0;
	float sin_half_angle = sin(half_angle);
	qr.x = axis.x * sin_half_angle;
	qr.y = axis.y * sin_half_angle;
	qr.z = axis.z * sin_half_angle;
	qr.w = cos(half_angle);
	return qr;
}
vec3 rotateWithAxisAngle(vec3 position, vec3 axis, float angle)
{
	vec4 q = quatFromAxisAngle(axis, angle);
	vec3 v = position.xyz;
	return v + 2.0 * cross(q.xyz, cross(q.xyz, v) + q.w * v);
}
// vec3 applyQuaternionToVector( vec4 q, vec3 v ){
// 	return v + 2.0 * cross( q.xyz, cross( q.xyz, v ) + q.w * v );
// }
vec3 rotateWithQuat( vec3 v, vec4 q )
{
	// vec4 qv = multQuat( quat, vec4(vec, 0.0) );
	// return multQuat( qv, vec4(-quat.x, -quat.y, -quat.z, quat.w) ).xyz;
	return v + 2.0 * cross( q.xyz, cross( q.xyz, v ) + q.w * v );
}
// https://github.com/glslify/glsl-look-at/blob/gh-pages/index.glsl
// mat3 rotation_matrix(vec3 origin, vec3 target, float roll) {
// 	vec3 rr = vec3(sin(roll), cos(roll), 0.0);
// 	vec3 ww = normalize(target - origin);
// 	vec3 uu = normalize(cross(ww, rr));
// 	vec3 vv = normalize(cross(uu, ww));

// 	return mat3(uu, vv, ww);
// }
// mat3 rotation_matrix(vec3 target, float roll) {
// 	vec3 rr = vec3(sin(roll), cos(roll), 0.0);
// 	vec3 ww = normalize(target);
// 	vec3 uu = normalize(cross(ww, rr));
// 	vec3 vv = normalize(cross(uu, ww));

// 	return mat3(uu, vv, ww);
// }

float vectorAngle(vec3 start, vec3 dest){
	start = normalize(start);
	dest = normalize(dest);

	float cosTheta = dot(start, dest);
	vec3 c1 = cross(start, dest);
	// We use the dot product of the cross with the Y axis.
	// This is a little arbitrary, but can still give a good sense of direction
	vec3 y_axis = vec3(0.0, 1.0, 0.0);
	float d1 = dot(c1, y_axis);
	float angle = acos(cosTheta) * sign(d1);
	return angle;
}

// http://www.opengl-tutorial.org/intermediate-tutorials/tutorial-17-quaternions/#i-need-an-equivalent-of-glulookat-how-do-i-orient-an-object-towards-a-point-
vec4 vectorAlign(vec3 start, vec3 dest){
	start = normalize(start);
	dest = normalize(dest);

	float cosTheta = dot(start, dest);
	vec3 axis;

	// if (cosTheta < -1 + 0.001f){
	// 	// special case when vectors in opposite directions:
	// 	// there is no ideal rotation axis
	// 	// So guess one; any will do as long as it's perpendicular to start
	// 	axis = cross(vec3(0.0f, 0.0f, 1.0f), start);
	// 	if (length2(axis) < 0.01 ) // bad luck, they were parallel, try again!
	// 		axis = cross(vec3(1.0f, 0.0f, 0.0f), start);

	// 	axis = normalize(axis);
	// 	return gtx::quaternion::angleAxis(glm::radians(180.0f), axis);
	// }
	if(cosTheta > (1.0 - 0.0001) || cosTheta < (-1.0 + 0.0001) ){
		axis = normalize(cross(start, vec3(0.0, 1.0, 0.0)));
		if (length(axis) < 0.001 ){ // bad luck, they were parallel, try again!
			axis = normalize(cross(start, vec3(1.0, 0.0, 0.0)));
		}
	} else {
		axis = normalize(cross(start, dest));
	}

	float angle = acos(cosTheta);

	return quatFromAxisAngle(axis, angle);
}
vec4 vectorAlignWithUp(vec3 start, vec3 dest, vec3 up){
	vec4 rot1 = vectorAlign(start, dest);
	up = normalize(up);

	// Recompute desiredUp so that it's perpendicular to the direction
	// You can skip that part if you really want to force desiredUp
	// vec3 right = normalize(cross(dest, up));
	// up = normalize(cross(right, dest));

	// Because of the 1rst rotation, the up is probably completely screwed up.
	// Find the rotation between the up of the rotated object, and the desired up
	vec3 newUp = rotateWithQuat(vec3(0.0, 1.0, 0.0), rot1);//rot1 * vec3(0.0, 1.0, 0.0);
	vec4 rot2 = vectorAlign(up, newUp);

	// return rot1;
	return rot2;
	// return multQuat(rot1, rot2);
	// return rot2 * rot1;

}

// https://www.euclideanspace.com/maths/geometry/rotations/conversions/quaternionToAngle/index.htm
float quatToAngle(vec4 q){
	return 2.0 * acos(q.w);
}
vec3 quatToAxis(vec4 q){
	return vec3(
		q.x / sqrt(1.0-q.w*q.w),
		q.y / sqrt(1.0-q.w*q.w),
		q.z / sqrt(1.0-q.w*q.w)
	);
}

vec4 align(vec3 dir, vec3 up){
	vec3 start_dir = vec3(0.0, 0.0, 1.0);
	vec3 start_up = vec3(0.0, 1.0, 0.0);
	vec4 rot1 = vectorAlign(start_dir, dir);
	up = normalize(up);

	// Recompute desiredUp so that it's perpendicular to the direction
	// You can skip that part if you really want to force desiredUp
	vec3 right = normalize(cross(dir, up));
	if(length(right)<0.001){
		right = vec3(1.0, 0.0, 0.0);
	}
	up = normalize(cross(right, dir));

	// Because of the 1rst rotation, the up is probably completely screwed up.
	// Find the rotation between the up of the rotated object, and the desired up
	vec3 newUp = rotateWithQuat(start_up, rot1);//rot1 * vec3(0.0, 1.0, 0.0);
	vec4 rot2 = vectorAlign(normalize(newUp), up);

	// return rot1;
	return quatMult(rot1, rot2);
	// return rot2 * rot1;

}

struct EnvMapProps {
	vec3 tint;
	float intensity;
	float roughness;
	float fresnel;
	float fresnelPower;
};
uniform sampler2D envMap;
uniform float envMapIntensity;
uniform float roughness;
#ifdef ROTATE_ENV_MAP_Y
	uniform float envMapRotationY;
#endif
vec3 envMapSample(vec3 rayDir, float envMapRoughness){
	// http://www.pocketgl.com/reflections/
	vec3 env = vec3(0.);
	// vec2 uv = vec2( atan( -rayDir.z, -rayDir.x ) * RECIPROCAL_PI2 + 0.5, rayDir.y * 0.5 + 0.5 );
	// vec3 env = texture2D(map, uv).rgb;
	#ifdef ENVMAP_TYPE_CUBE_UV
		#ifdef ROTATE_ENV_MAP_Y
			rayDir = rotateWithAxisAngle(rayDir, vec3(0.,1.,0.), envMapRotationY);
		#endif
		env = textureCubeUV(envMap, rayDir, envMapRoughness * roughness).rgb;
	#endif
	return env;
}
vec3 envMapSampleWithFresnel(vec3 rayDir, EnvMapProps envMapProps, vec3 n, vec3 cameraPosition){
	// http://www.pocketgl.com/reflections/
	vec3 env = envMapSample(rayDir, envMapProps.roughness);
	float fresnel = pow(1.-dot(normalize(cameraPosition), n), envMapProps.fresnelPower);
	float fresnelFactor = (1.-envMapProps.fresnel) + envMapProps.fresnel*fresnel;
	return env * envMapIntensity * envMapProps.tint * envMapProps.intensity * fresnelFactor;
}
#define RAYMARCHED_REFRACTIONS 1
#define RAYMARCHED_REFRACTIONS_SAMPLE_ENV_MAP_ON_LAST 1
#define RAYMARCHED_REFRACTIONS_START_OUTSIDE_MEDIUM 1







// /raymarchedObject/MAT/rayMarchingBuilder1/textureSDF1
precision highp sampler3D;

// /raymarchedObject/MAT/rayMarchingBuilder1/textureSDF1BoundMin
uniform vec3 v_POLY_param_textureSDF1BoundMin;

// /raymarchedObject/MAT/rayMarchingBuilder1/textureSDF1BoundMax
uniform vec3 v_POLY_param_textureSDF1BoundMax;

// /raymarchedObject/MAT/rayMarchingBuilder1/globals1
uniform float time;

// /raymarchedObject/MAT/rayMarchingBuilder1/textureSDF1
uniform sampler3D v_POLY_textureSDF_textureSDF1;






SDFContext GetDist(vec3 p) {
	SDFContext sdfContext = SDFContext(0., 0, 0, 0, 0.);

	// start GetDist builder body code



	// /raymarchedObject/MAT/rayMarchingBuilder1/textureSDF1BoundMin
	vec3 v_POLY_textureSDF1BoundMin_val = v_POLY_param_textureSDF1BoundMin;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/textureSDF1BoundMax
	vec3 v_POLY_textureSDF1BoundMax_val = v_POLY_param_textureSDF1BoundMax;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/globals1
	vec3 v_POLY_globals1_position = p;
	float v_POLY_globals1_time = time;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/textureSDF1
	vec3 v_POLY_textureSDF1_boundCenter = (v_POLY_textureSDF1BoundMax_val + v_POLY_textureSDF1BoundMin_val)*0.5;
	vec3 v_POLY_textureSDF1_boundSize = (v_POLY_textureSDF1BoundMax_val - v_POLY_textureSDF1BoundMin_val);
	vec3 v_POLY_textureSDF1_positionNormalised = ((p - v_POLY_textureSDF1BoundMin_val) / v_POLY_textureSDF1_boundSize);
	float v_POLY_textureSDF1_sdBox = sdBox(p-v_POLY_textureSDF1_boundCenter, v_POLY_textureSDF1_boundSize*vec3(1.0, 1.0, 1.0));
	float v_POLY_textureSDF1_d = v_POLY_textureSDF1_sdBox < 0.01 ? texture(v_POLY_textureSDF_textureSDF1, v_POLY_textureSDF1_positionNormalised - vec3(0.0, 0.0, 0.0)).r : v_POLY_textureSDF1_sdBox;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/cycle1
	float v_POLY_cycle1_val = cycle(v_POLY_globals1_time, 0.0, 12.5);
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/vec3ToFloat1
	float v_POLY_vec3ToFloat1_x = v_POLY_globals1_position.x;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/multAdd4
	float v_POLY_multAdd4_val = (0.2*(v_POLY_cycle1_val + 0.0)) + 0.22;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/multAdd2
	float v_POLY_multAdd2_val = (1.0*(v_POLY_multAdd4_val + 0.0)) + -1.0;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/multAdd5
	float v_POLY_multAdd5_val = (1.0*(v_POLY_multAdd4_val + 0.0)) + -2.0;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/null1
	float v_POLY_null1_val = v_POLY_multAdd2_val;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/null2
	float v_POLY_null2_val = v_POLY_multAdd5_val;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/multAdd6
	float v_POLY_multAdd6_val = (1.0*(v_POLY_null1_val + 1.0)) + 0.0;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/multAdd7
	float v_POLY_multAdd7_val = (1.0*(v_POLY_null2_val + -1.0)) + 0.0;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/smoothstep1
	float v_POLY_smoothstep1_val = smoothstep(v_POLY_null1_val, v_POLY_multAdd6_val, v_POLY_vec3ToFloat1_x);
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/smoothstep2
	float v_POLY_smoothstep2_val = smoothstep(v_POLY_null2_val, v_POLY_multAdd7_val, v_POLY_vec3ToFloat1_x);
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/max1
	float v_POLY_max1_val = max(v_POLY_smoothstep1_val, v_POLY_smoothstep2_val);
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/multAdd1
	float v_POLY_multAdd1_val = (0.31*(v_POLY_max1_val + 0.0)) + 0.0;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/multAdd3
	float v_POLY_multAdd3_val = (1.0*(v_POLY_textureSDF1_d + v_POLY_multAdd1_val)) + 0.0;
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/SDFContext1
	SDFContext v_POLY_SDFContext1_SDFContext = SDFContext(v_POLY_multAdd3_val, 0, _RAYMARCHEDOBJECT_MAT_RAYMARCHINGBUILDER1_SDFMATERIAL1, _RAYMARCHEDOBJECT_MAT_RAYMARCHINGBUILDER1_SDFMATERIAL1, 0.);
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/output1
	sdfContext = v_POLY_SDFContext1_SDFContext;



	

	return sdfContext;
}

SDFContext RayMarch(vec3 ro, vec3 rd, float side) {
	SDFContext dO = SDFContext(0.,0,0,0,0.);

	#pragma unroll_loop_start
	for(int i=0; i<MAX_STEPS; i++) {
		vec3 p = ro + rd*dO.d;
		SDFContext sdfContext = GetDist(p);
		dO.d += sdfContext.d * side;
		#if defined( DEBUG_STEPS_COUNT )
			dO.stepsCount += 1;
		#endif
		dO.matId = sdfContext.matId;
		dO.matId2 = sdfContext.matId2;
		dO.matBlend = sdfContext.matBlend;
		if(dO.d>MAX_DIST || abs(sdfContext.d)<SURF_DIST) break;
	}
	#pragma unroll_loop_end

	return dO;
}

vec3 GetNormal(vec3 p) {
	SDFContext sdfContext = GetDist(p);
	vec2 e = vec2(NORMALS_BIAS, 0);

	vec3 n = sdfContext.d - vec3(
		GetDist(p-e.xyy).d,
		GetDist(p-e.yxy).d,
		GetDist(p-e.yyx).d);

	return normalize(n);
}
// https://iquilezles.org/articles/rmshadows
float calcSoftshadow( in vec3 ro, in vec3 rd, float mint, float maxt, float k, inout SDFContext sdfContext )
{
	float res = 1.0;
	float ph = 1e20;
	for( float t=mint; t<maxt; )
	{
		float h = GetDist(ro + rd*t).d;
		#if defined( DEBUG_STEPS_COUNT )
			sdfContext.stepsCount += 1;
		#endif
		if( h<SURF_DIST )
			return 0.0;
		float y = h*h/(2.0*ph);
		float d = sqrt(h*h-y*y);
		res = min( res, k*d/max(0.0,t-y) );
		ph = h;
		t += h;
	}
	return res;
}

vec3 GetLight(vec3 _p, vec3 _n, inout SDFContext sdfContext) {
	vec3 dif = vec3(0.,0.,0.);
	GeometricContext geometry;
	// geometry.position = _p;
	// geometry.normal = _n;
	// geometry.viewDir = rayDir;

	// vec4 mvPosition = vec4( p, 1.0 );
	// mvPosition = modelViewMatrix * mvPosition;
	// vec3 vViewPosition = - mvPosition.xyz;
	vec3 pWorld = ( vModelMatrix * vec4( _p, 1.0 )).xyz;
	vec3 nWorld = transformDirection(_n, vModelMatrix);
	// geometry.position = (VViewMatrix * vec4( _p, 1.0 )).xyz;
	geometry.position = (VViewMatrix * vec4(pWorld, 1.0 )).xyz;
	// geometry.normal = transformDirection(_n, VViewMatrix);
	// geometry.normal = inverseTransformDirection(transformDirection(_n, VViewMatrix), vInverseModelMatrix);
	geometry.normal = transformDirection(nWorld, VViewMatrix);
	geometry.viewDir = ( isOrthographic ) ? vec3( 0, 0, 1 ) : normalize( cameraPosition - geometry.position );

	#if NUM_SPOT_LIGHTS > 0 || NUM_DIR_LIGHTS > 0 || NUM_HEMI_LIGHTS > 0 || NUM_POINT_LIGHTS > 0 || NUM_RECT_AREA_LIGHTS > 0

		IncidentLight directLight;
		ReflectedLight reflectedLight;
		vec3 lightPos, lightDir, worldLightDir, objectSpaceLightDir, lighDif, directDiffuse;
		float dotNL, lightDistance;
		#if NUM_SPOT_LIGHTS > 0
			SpotLightRayMarching spotLightRayMarching;
			SpotLight spotLight;
			float spotLightSdfShadow;
			#if defined( USE_SHADOWMAP ) && NUM_SPOT_LIGHT_SHADOWS > 0
				SpotLightShadow spotLightShadow;
			#endif
			#pragma unroll_loop_start
			for ( int i = 0; i < NUM_SPOT_LIGHTS; i ++ ) {
				spotLightRayMarching = spotLightsRayMarching[ i ];
				spotLight = spotLights[ i ];
				getSpotLightInfo( spotLight, geometry, directLight );

				// #if defined( USE_SHADOWMAP ) && ( UNROLLED_LOOP_INDEX < NUM_SPOT_LIGHT_SHADOWS )
				// 	spotLightShadow = spotLightShadows[ i ];
				// 	vec4 spotLightShadowCoord = spotLightMatrix[ i ] * vec4(pWorld+SHADOW_BIAS*nWorld, 1.0);
				// 	directLight.color *= (directLight.visible && receiveShadow) ? getShadow(
				// 		spotShadowMap[ i ],
				// 		spotLightShadow.shadowMapSize,
				// 		spotLightShadow.shadowBias,
				// 		spotLightShadow.shadowRadius,
				// 		spotLightShadowCoord
				// 	) : 1.0;
				// #endif

				lightPos = spotLight.position;
				lightDir = normalize(lightPos-geometry.position);
				worldLightDir = inverseTransformDirection(lightDir, VViewMatrix);
				objectSpaceLightDir = inverseTransformDirection(worldLightDir, vModelMatrix);
				lightDistance = distance(geometry.position,lightPos);
				spotLightSdfShadow =
					dot( _n, objectSpaceLightDir ) < spotLightRayMarching.shadowBiasAngle
					? 1.
					: calcSoftshadow(
						_p,
						objectSpaceLightDir,
						spotLightRayMarching.shadowBiasDistance,
						distance(geometry.position,lightPos),
						1./max(spotLightRayMarching.penumbra*0.2,0.001),
						sdfContext
					);
				dotNL = saturate( dot( geometry.normal, directLight.direction ) );
				directDiffuse = dotNL * directLight.color * BRDF_Lambert( vec3(1.) );
				dif += directDiffuse * spotLightSdfShadow;
			}
			#pragma unroll_loop_end
		#endif
		#if NUM_DIR_LIGHTS > 0
			DirectionalLightRayMarching directionalLightRayMarching;
			DirectionalLight directionalLight;
			float dirLightSdfShadow;
			#if defined( USE_SHADOWMAP ) && NUM_DIR_LIGHT_SHADOWS > 0
				DirectionalLightShadow directionalLightShadow;
			#endif
			#pragma unroll_loop_start
			for ( int i = 0; i < NUM_DIR_LIGHTS; i ++ ) {
				directionalLightRayMarching = directionalLightsRayMarching[ i ];
				directionalLight = directionalLights[ i ];
				
				getDirectionalLightInfo( directionalLight, geometry, directLight );

				// #if defined( USE_SHADOWMAP ) && ( UNROLLED_LOOP_INDEX < NUM_DIR_LIGHT_SHADOWS )
				// 	directionalLightShadow = directionalLightShadows[ i ];
				// 	vec4 dirLightShadowCoord = directionalShadowMatrix[ i ] * vec4(pWorld+SHADOW_BIAS*nWorld, 1.0);
				// 	directLight.color *= (directLight.visible && receiveShadow) ? getShadow(
				// 		directionalShadowMap[ i ],
				// 		directionalLightShadow.shadowMapSize,
				// 		directionalLightShadow.shadowBias,
				// 		directionalLightShadow.shadowRadius,
				// 		dirLightShadowCoord
				// 	) : 1.0;
				// #endif

				lightDir = directionalLight.direction;
				worldLightDir = inverseTransformDirection(lightDir, VViewMatrix);
				objectSpaceLightDir = inverseTransformDirection(worldLightDir, vModelMatrix);
				dirLightSdfShadow =
					dot( _n, objectSpaceLightDir ) < directionalLightRayMarching.shadowBiasAngle
					? 1.
					:
					calcSoftshadow(
						_p,
						objectSpaceLightDir,
						directionalLightRayMarching.shadowBiasDistance,
						MAX_DIST,//distance(geometry.position,lightPos),
						1./max(directionalLightRayMarching.penumbra*0.2,0.001),
						sdfContext
					);
				dotNL = saturate( dot( geometry.normal, directLight.direction ) );
				// lighDif = directLight.color * dotNL * dirLightSdfShadow;
				directDiffuse = dotNL * directLight.color * BRDF_Lambert( vec3(1.) );
				dif += directDiffuse * dirLightSdfShadow;
			}
			#pragma unroll_loop_end
		#endif

		#if ( NUM_HEMI_LIGHTS > 0 )

			#pragma unroll_loop_start
			HemisphereLight hemiLight;
			for ( int i = 0; i < NUM_HEMI_LIGHTS; i ++ ) {
				hemiLight = hemisphereLights[ i ];
				dif += getHemisphereLightIrradiance( hemiLight, geometry.normal ) * BRDF_Lambert( vec3(1.) );

			}
			#pragma unroll_loop_end

		#endif

		#if NUM_POINT_LIGHTS > 0
			PointLightRayMarching pointLightRayMarching;
			PointLight pointLight;
			float pointLightSdfShadow;
			#if defined( USE_SHADOWMAP ) && NUM_POINT_LIGHT_SHADOWS > 0
				PointLightShadow pointLightShadow;
			#endif
			#pragma unroll_loop_start
			for ( int i = 0; i < NUM_POINT_LIGHTS; i ++ ) {
				pointLightRayMarching = pointLightsRayMarching[ i ];
				pointLight = pointLights[ i ];
				getPointLightInfo( pointLight, geometry, directLight );


				#if defined( USE_SHADOWMAP ) && ( UNROLLED_LOOP_INDEX < NUM_POINT_LIGHT_SHADOWS )
					pointLightShadow = pointLightShadows[ i ];
					vec4 pointLightShadowCoord = pointShadowMatrix[ i ] * vec4(pWorld+SHADOW_BIAS*nWorld, 1.0);
					directLight.color *= (directLight.visible && receiveShadow) ? getPointShadow(
						pointShadowMap[ i ],
						pointLightShadow.shadowMapSize,
						pointLightShadow.shadowBias,
						pointLightShadow.shadowRadius,
						pointLightShadowCoord,
						pointLightShadow.shadowCameraNear,
						pointLightShadow.shadowCameraFar
					) : 1.0;
				#endif

				lightPos = pointLight.position;
				lightDir = normalize(lightPos-geometry.position);
				worldLightDir = inverseTransformDirection(lightDir, VViewMatrix);
				objectSpaceLightDir = inverseTransformDirection(worldLightDir, vModelMatrix);
				pointLightSdfShadow =
					dot( _n, objectSpaceLightDir ) < pointLightRayMarching.shadowBiasAngle
					? 1.
					:
					calcSoftshadow(
					_p,
					objectSpaceLightDir,
					pointLightRayMarching.shadowBiasDistance,
					distance(geometry.position,lightPos),
					1./max(pointLightRayMarching.penumbra*0.2,0.001),
					sdfContext
				);
				dotNL = saturate( dot( geometry.normal, directLight.direction ) );
				directDiffuse = dotNL * directLight.color * BRDF_Lambert( vec3(1.) );
				dif += directDiffuse * pointLightSdfShadow;
			}
			#pragma unroll_loop_end
		#endif

		#if ( NUM_RECT_AREA_LIGHTS > 0 ) && defined( RE_Direct_RectArea )

			RectAreaLight rectAreaLight;
			// AreaLightRayMarching areaLightRayMarching;
			PhysicalMaterial material;
			material.roughness = 1.;
			material.specularColor = vec3(1.);
			material.diffuseColor = vec3(1.);

			#pragma unroll_loop_start
			for ( int i = 0; i < NUM_RECT_AREA_LIGHTS; i ++ ) {
				// areaLightRayMarching = areaLightsRayMarching[ i ];
				rectAreaLight = rectAreaLights[ i ];
				// rectAreaLight.position = areaLightRayMarching.worldPos;

				RE_Direct_RectArea( rectAreaLight, geometry, material, reflectedLight );
			}
			#pragma unroll_loop_end
			dif += reflectedLight.directDiffuse;

		#endif
	#endif

	vec3 irradiance = getAmbientLightIrradiance( ambientLightColor );

	irradiance += getLightProbeIrradiance( lightProbe, geometry.normal );
	dif += irradiance;
	return dif;
}




vec3 applyMaterialWithoutRefraction(vec3 p, vec3 n, vec3 rayDir, int mat, inout SDFContext sdfContext){

	vec3 col = vec3(1.);
	// start applyMaterial builder body code



	// /raymarchedObject/MAT/rayMarchingBuilder1/constant1
	vec3 v_POLY_constant1_val = vec3(1.0, 1.0, 1.0);
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/SDFMaterial1
	if(mat == _RAYMARCHEDOBJECT_MAT_RAYMARCHINGBUILDER1_SDFMATERIAL1){
		col = vec3(0., 0., 0.);
		vec3 diffuse = v_POLY_constant1_val * vec3(0.0, 0.0, 0.0) * GetLight(p, n, sdfContext);
		col += diffuse;
		col += vec3(0.0, 0.0, 0.0);
		vec3 rayDir = normalize(reflect(rayDir, n));
		EnvMapProps envMapProps;
		envMapProps.tint = vec3(1.0, 1.0, 1.0);
		envMapProps.intensity = 0.14;
		envMapProps.roughness = 1.0;
		envMapProps.fresnel = 0.0;
		envMapProps.fresnelPower = 5.0;
		col += envMapSampleWithFresnel(rayDir, envMapProps, n, cameraPosition);
	
	;
	}



	
	return col;
}

vec3 applyMaterialWithoutReflection(vec3 p, vec3 n, vec3 rayDir, int mat, inout SDFContext sdfContext){

	vec3 col = vec3(1.);
	// start applyMaterial builder body code



	// /raymarchedObject/MAT/rayMarchingBuilder1/constant1
	vec3 v_POLY_constant1_val = vec3(1.0, 1.0, 1.0);
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/SDFMaterial1
	if(mat == _RAYMARCHEDOBJECT_MAT_RAYMARCHINGBUILDER1_SDFMATERIAL1){
		col = vec3(0., 0., 0.);
		vec3 diffuse = v_POLY_constant1_val * vec3(0.0, 0.0, 0.0) * GetLight(p, n, sdfContext);
		col += diffuse;
		col += vec3(0.0, 0.0, 0.0);
		vec3 rayDir = normalize(reflect(rayDir, n));
		EnvMapProps envMapProps;
		envMapProps.tint = vec3(1.0, 1.0, 1.0);
		envMapProps.intensity = 0.14;
		envMapProps.roughness = 1.0;
		envMapProps.fresnel = 0.0;
		envMapProps.fresnelPower = 5.0;
		col += envMapSampleWithFresnel(rayDir, envMapProps, n, cameraPosition);
	
	;
	}



	
	return col;
}
#ifdef RAYMARCHED_REFLECTIONS
vec3 GetReflection(vec3 p, vec3 n, vec3 rayDir, float biasMult, float roughness, int reflectionDepth, inout SDFContext sdfContextMain){
	bool hitReflection = true;
	vec3 reflectedColor = vec3(0.);
	#pragma unroll_loop_start
	for(int i=0; i < reflectionDepth; i++) {
		if(hitReflection){
			rayDir = reflect(rayDir, n);
			p += n*SURF_DIST*biasMult;
			SDFContext sdfContext = RayMarch(p, rayDir, 1.);
			#if defined( DEBUG_STEPS_COUNT )
				sdfContextMain.stepsCount += sdfContext.stepsCount;
			#endif
			if( sdfContext.d >= MAX_DIST){
				hitReflection = false;
				reflectedColor = envMapSample(rayDir, roughness);
			}
			if(hitReflection){
				p += rayDir * sdfContext.d;
				n = GetNormal(p);
				vec3 matCol = applyMaterialWithoutReflection(p, n, rayDir, sdfContext.matId, sdfContextMain);
				reflectedColor += matCol;
			}
		}
	}
	#pragma unroll_loop_end
	return reflectedColor;
}
#endif

#ifdef RAYMARCHED_REFRACTIONS
// xyz for color, w for distanceInsideMedium
vec4 GetRefractedData(vec3 p, vec3 n, vec3 rayDir, float ior, float biasMult, float roughness, float refractionMaxDist, int refractionDepth, inout SDFContext sdfContextMain){
	bool hitRefraction = true;
	bool changeSide = true;
	#ifdef RAYMARCHED_REFRACTIONS_START_OUTSIDE_MEDIUM
	float side = -1.;
	#else
	float side =  1.;
	#endif
	float iorInverted = 1. / ior;
	vec3 refractedColor = vec3(0.);
	float distanceInsideMedium=0.;
	float totalRefractedDistance=0.;

	#pragma unroll_loop_start
	for(int i=0; i < refractionDepth; i++) {
		if(hitRefraction){
			float currentIor = side<0. ? iorInverted : ior;
			vec3 rayDirPreRefract = rayDir;
			rayDir = refract(rayDir, n, currentIor);
			changeSide = dot(rayDir, rayDir)!=0.;
			if(changeSide == true) {
				p -= n*SURF_DIST*(2.+biasMult);
			} else {
				p += n*SURF_DIST*(   biasMult);
				rayDir = reflect(rayDirPreRefract, n);
			}
			SDFContext sdfContext = RayMarch(p, rayDir, side);
			#if defined( DEBUG_STEPS_COUNT )
				sdfContextMain.stepsCount += sdfContext.stepsCount;
			#endif
			totalRefractedDistance += sdfContext.d;
			if( abs(sdfContext.d) >= MAX_DIST || totalRefractedDistance > refractionMaxDist ){
				hitRefraction = false;
				refractedColor = envMapSample(rayDir, roughness);
			}
			if(hitRefraction){
				p += rayDir * sdfContext.d;
				n = GetNormal(p) * side;
				vec3 matCol = applyMaterialWithoutRefraction(p, n, rayDir, sdfContext.matId, sdfContextMain);
				refractedColor = matCol;

				// same as: side < 0. ? abs(sdfContext.d) : 0.;
				distanceInsideMedium += (side-1.)*-0.5*abs(sdfContext.d);
				if( changeSide ){
					side *= -1.;
				}
			}
		}
		#ifdef RAYMARCHED_REFRACTIONS_SAMPLE_ENV_MAP_ON_LAST
		if(i == refractionDepth-1){
			refractedColor = envMapSample(rayDir, roughness);
		}
		#endif
	}
	#pragma unroll_loop_end
	return vec4(refractedColor, distanceInsideMedium);
}
float refractionTint(float baseValue, float tint, float distanceInsideMedium, float absorption){
	float tintNegated = baseValue-tint;
	float t = tintNegated*( distanceInsideMedium*absorption );
	return max(baseValue-t, 0.);
}
float applyRefractionAbsorption(float refractedDataColor, float baseValue, float tint, float distanceInsideMedium, float absorption){
	return refractedDataColor*refractionTint(baseValue, tint, distanceInsideMedium, absorption);
}
vec3 applyRefractionAbsorption(vec3 refractedDataColor, vec3 baseValue, vec3 tint, float distanceInsideMedium, float absorption){
	return vec3(
		refractedDataColor.r * refractionTint(baseValue.r, tint.r, distanceInsideMedium, absorption),
		refractedDataColor.g * refractionTint(baseValue.g, tint.g, distanceInsideMedium, absorption),
		refractedDataColor.b * refractionTint(baseValue.b, tint.b, distanceInsideMedium, absorption)
	);
}

#endif

vec3 applyMaterial(vec3 p, vec3 n, vec3 rayDir, int mat, inout SDFContext sdfContext){

	vec3 col = vec3(0.);
	// start applyMaterial builder body code



	// /raymarchedObject/MAT/rayMarchingBuilder1/constant1
	vec3 v_POLY_constant1_val = vec3(1.0, 1.0, 1.0);
	
	// /raymarchedObject/MAT/rayMarchingBuilder1/SDFMaterial1
	if(mat == _RAYMARCHEDOBJECT_MAT_RAYMARCHINGBUILDER1_SDFMATERIAL1){
		col = vec3(0., 0., 0.);
		vec3 diffuse = v_POLY_constant1_val * vec3(0.0, 0.0, 0.0) * GetLight(p, n, sdfContext);
		col += diffuse;
		col += vec3(0.0, 0.0, 0.0);
		vec3 rayDir = normalize(reflect(rayDir, n));
		EnvMapProps envMapProps;
		envMapProps.tint = vec3(1.0, 1.0, 1.0);
		envMapProps.intensity = 0.14;
		envMapProps.roughness = 1.0;
		envMapProps.fresnel = 0.0;
		envMapProps.fresnelPower = 5.0;
		col += envMapSampleWithFresnel(rayDir, envMapProps, n, cameraPosition);
	
		vec3 refractedColor = vec3(0.);
		float ior = 1.45;
		float biasMult = 2.0;
		vec3 baseValue = v_POLY_constant1_val;
		vec3 tint = vec3(0.7764705882352941, 0.5490196078431373, 0.06274509803921569);
		float absorption = 4.7;
			
	
		vec4 refractedData = GetRefractedData(p, n, rayDir, ior, biasMult, 1.0, 100.0, 3, sdfContext);
		refractedColor = applyRefractionAbsorption(refractedData.rgb, baseValue, tint, refractedData.w, absorption);
				;
	
		col += refractedColor * 2.0;
	;
	}



	
	return col;
}




vec4 applyShading(vec3 rayOrigin, vec3 rayDir, inout SDFContext sdfContext){
	vec3 p = rayOrigin + rayDir * sdfContext.d;
	vec3 n = GetNormal(p);
	
	vec3 col = applyMaterial(p, n, rayDir, sdfContext.matId, sdfContext);
	if(sdfContext.matBlend > 0.) {
		// blend material colors if needed
		vec3 col2 = applyMaterial(p, n, rayDir, sdfContext.matId2, sdfContext);
		col = (1. - sdfContext.matBlend)*col + sdfContext.matBlend*col2;
	}
		
	// gamma
	//col = pow( col, vec3(0.4545) ); // this gamma leads to a different look than standard materials
	return vec4(col, 1.);
}

void main()	{

	vec3 rayDir = normalize(vPw - cameraPosition);
	rayDir = transformDirection(rayDir, vInverseModelMatrix);
	vec3 rayOrigin = (vInverseModelMatrix * vec4( cameraPosition, 1.0 )).xyz;

	SDFContext sdfContext = RayMarch(rayOrigin, rayDir, 1.);

	#if defined( DEBUG_DEPTH )
		float normalizedDepth = 1.-(sdfContext.d - debugMinDepth ) / ( debugMaxDepth - debugMinDepth );
		normalizedDepth = saturate(normalizedDepth); // clamp to [0,1]
		gl_FragColor = vec4(normalizedDepth);
		return;
	#endif
	#if defined( SHADOW_DEPTH )
		float normalizedDepth = 1.-(sdfContext.d - debugMinDepth ) / ( debugMaxDepth - debugMinDepth );
		// float fragCoordZ = sdfContext.d / vHighPrecisionZW[1];
		float compoundedDepth = 0.5 * (normalizedDepth) + 0.5;
		float alpha = sdfContext.d < MAX_DIST ? 0.:1.;
		gl_FragColor = vec4( vec3(compoundedDepth), alpha );
		// normalizedDepth = 0.5*normalizedDepth+0.5;
		// gl_FragColor = packDepthToRGBA( normalizedDepth );
		// gl_FragColor = vec4(0.);
		return;
	#endif
	#if defined( SHADOW_DISTANCE )
		float normalizedDepth = (sdfContext.d - shadowDistanceMin ) / ( shadowDistanceMax - shadowDistanceMin );
		normalizedDepth = saturate(normalizedDepth); // clamp to [0,1]
		gl_FragColor = packDepthToRGBA( normalizedDepth );
		return;
	#endif

	if( sdfContext.d < MAX_DIST ){
		gl_FragColor = applyShading(rayOrigin, rayDir, sdfContext);
		#if defined( TONE_MAPPING )
			gl_FragColor.rgb = toneMapping( gl_FragColor.rgb );
		#endif
		gl_FragColor = linearToOutputTexel( gl_FragColor );

		#ifdef USE_FOG
			float vFogDepth = sdfContext.d;
			#ifdef FOG_EXP2
				float fogFactor = 1.0 - exp( - fogDensity * fogDensity * vFogDepth * vFogDepth );
			#else
				float fogFactor = smoothstep( fogNear, fogFar, vFogDepth );
			#endif
			gl_FragColor.rgb = mix( gl_FragColor.rgb, fogColor, fogFactor );
		#endif
		#include <premultiplied_alpha_fragment>
		#include <dithering_fragment>
	} else {
		gl_FragColor = vec4(0.);
	}

	#if defined( DEBUG_STEPS_COUNT )
		float normalizedStepsCount = (float(sdfContext.stepsCount) - debugMinSteps ) / ( debugMaxSteps - debugMinSteps );
		gl_FragColor = vec4(normalizedStepsCount, 1.-normalizedStepsCount, 0., 1.);
		return;
	#endif
	
}
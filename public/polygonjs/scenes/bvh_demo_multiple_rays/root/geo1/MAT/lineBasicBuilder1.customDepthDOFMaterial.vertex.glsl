
uniform float scale;
attribute float lineDistance;

varying float vLineDistance;


#include <common>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <morphtarget_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>

// INSERT DEFINES



// /geo1/MAT/lineBasicBuilder1/laserColor1/attribute1
varying float v_POLY_attribute_id;

// /geo1/MAT/lineBasicBuilder1/laserColor1/attribute1
attribute float id;






// vHighPrecisionZW is added to match CustomMeshDepth.frag
// which is itself taken from threejs
varying vec2 vHighPrecisionZW;


void main() {

	// INSERT BODY



	// /geo1/MAT/lineBasicBuilder1/laserColor1
	float v_POLY_laserColor1_attribute1_val = id;
	v_POLY_attribute_id = float(id);
	
	// /geo1/MAT/lineBasicBuilder1/output1
	vec3 transformed = vec3( position );vec4 mvPosition = vec4( transformed, 1.0 ); gl_Position = projectionMatrix * modelViewMatrix * mvPosition;





	vLineDistance = scale * lineDistance;

	#include <color_vertex>
// removed:
//	#include <begin_vertex>
	#include <morphtarget_vertex>
// removed:
//	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	#include <fog_vertex>


	vHighPrecisionZW = gl_Position.zw;
}

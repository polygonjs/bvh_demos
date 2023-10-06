uniform float scale;
attribute float lineDistance;
varying float vLineDistance;
#include <common>



// /geo1/MAT/lineBasicBuilder1/laserColor1/attribute1
varying float v_POLY_attribute_id;

// /geo1/MAT/lineBasicBuilder1/laserColor1/attribute1
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



	// /geo1/MAT/lineBasicBuilder1/laserColor1
	float v_POLY_laserColor1_attribute1_val = id;
	v_POLY_attribute_id = float(id);
	
	// /geo1/MAT/lineBasicBuilder1/output1
	vec3 transformed = vec3( position );vec4 mvPosition = vec4( transformed, 1.0 ); gl_Position = projectionMatrix * modelViewMatrix * mvPosition;



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
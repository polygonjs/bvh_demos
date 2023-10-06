
// INSERT DEFINES

#define DISTANCE

uniform vec3 referencePosition;
uniform float nearDistance;
uniform float farDistance;
varying vec3 vWorldPosition;

#include <common>



// /geo1/MAT/meshStandardBuilder1/param1
uniform float v_POLY_param_selectedId;

// /geo1/MAT/meshStandardBuilder1/attribute1
varying float v_POLY_attribute_id;




#include <packing>
#include <uv_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <clipping_planes_pars_fragment>

struct SSSModel {
	bool isActive;
	vec3 color;
	float thickness;
	float power;
	float scale;
	float distortion;
	float ambient;
	float attenuation;
};

void RE_Direct_Scattering(
	const in IncidentLight directLight,
	const in GeometricContext geometry,
	const in SSSModel sssModel,
	inout ReflectedLight reflectedLight
	){
	vec3 scatteringHalf = normalize(directLight.direction + (geometry.normal * sssModel.distortion));
	float scatteringDot = pow(saturate(dot(geometry.viewDir, -scatteringHalf)), sssModel.power) * sssModel.scale;
	vec3 scatteringIllu = (scatteringDot + sssModel.ambient) * (sssModel.color * (1.0-sssModel.thickness));
	reflectedLight.directDiffuse += scatteringIllu * sssModel.attenuation * directLight.color;
}

void main() {

	#include <clipping_planes_fragment>

	vec4 diffuseColor = vec4( 1.0 );

	#include <map_fragment>
	#include <alphamap_fragment>



	// /geo1/MAT/meshStandardBuilder1/attribute1
	float v_POLY_attribute1_val = v_POLY_attribute_id;
	
	// /geo1/MAT/meshStandardBuilder1/param1
	float v_POLY_param1_val = v_POLY_param_selectedId;
	
	// /geo1/MAT/meshStandardBuilder1/constant1
	vec3 v_POLY_constant1_val = vec3(1.0, 1.0, 1.0);
	
	// /geo1/MAT/meshStandardBuilder1/round1
	float v_POLY_round1_val = sign(v_POLY_attribute1_val)*floor(abs(v_POLY_attribute1_val)+0.5);
	
	// /geo1/MAT/meshStandardBuilder1/round2
	float v_POLY_round2_val = sign(v_POLY_param1_val)*floor(abs(v_POLY_param1_val)+0.5);
	
	// /geo1/MAT/meshStandardBuilder1/multScalar1
	vec3 v_POLY_multScalar1_val = (3.0*v_POLY_constant1_val);
	
	// /geo1/MAT/meshStandardBuilder1/compare1
	bool v_POLY_compare1_val = (v_POLY_round1_val == v_POLY_round2_val);
	
	// /geo1/MAT/meshStandardBuilder1/twoWaySwitch1
	vec3 v_POLY_twoWaySwitch1_val;
	if(v_POLY_compare1_val){
	v_POLY_twoWaySwitch1_val = v_POLY_multScalar1_val;
	} else {
	v_POLY_twoWaySwitch1_val = v_POLY_constant1_val;
	}
	
	// /geo1/MAT/meshStandardBuilder1/output1
	diffuseColor.xyz = v_POLY_twoWaySwitch1_val;
	float POLY_metalness = 1.0;
	float POLY_roughness = 1.0;
	vec3 POLY_emissive = vec3(1.0, 1.0, 1.0);
	SSSModel POLY_SSSModel = SSSModel(/*isActive*/false,/*color*/vec3(1.0, 1.0, 1.0), /*thickness*/0.1, /*power*/2.0, /*scale*/16.0, /*distortion*/0.1,/*ambient*/0.4,/*attenuation*/0.8 );




	// INSERT BODY

	#include <alphatest_fragment>

	float dist = length( vWorldPosition - referencePosition );
	dist = ( dist - nearDistance ) / ( farDistance - nearDistance );
	dist = saturate( dist ); // clamp to [ 0, 1 ]

	gl_FragColor = packDepthToRGBA( dist );

}

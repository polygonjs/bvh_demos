// cop
import { EnvMapCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/EnvMap";
import { ImageCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/Image";
import { ImageEXRCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/ImageEXR";
// event
import { CameraOrbitControlsEventNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/event/CameraOrbitControls";
// mat
import { LineBasicBuilderMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/LineBasicBuilder";
import { MeshStandardMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshStandard";
import { MeshStandardBuilderMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshStandardBuilder";
import { PointsBuilderMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/PointsBuilder";
import { SkyMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/Sky";
// obj
import { CopNetworkObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/CopNetwork";
import { GeoObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/Geo";
// sop
import { BVHSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/BVH";
import { BVHVisualizerSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/BVHVisualizer";
import { ActorSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Actor";
import { AddSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Add";
import { AreaLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/AreaLight";
import { AttribCreateSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/AttribCreate";
import { AttribDeleteSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/AttribDelete";
import { AttribIdSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/AttribId";
import { BoxSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Box";
import { CameraControlsSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/CameraControls";
import { CircleSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Circle";
import { CopySopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Copy";
import { FileGLTFSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/FileGLTF";
import { HemisphereLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/HemisphereLight";
import { HierarchySopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Hierarchy";
import { JitterSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Jitter";
import { LineSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Line";
import { MaterialSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Material";
import { MaterialsNetworkSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/MaterialsNetwork";
import { MergeSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Merge";
import { ObjectPropertiesSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/ObjectProperties";
import { PerspectiveCameraSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PerspectiveCamera";
import { PolarTransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PolarTransform";
import { SphereSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Sphere";
import { SpotLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/SpotLight";
import { TransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Transform";
import { TubeSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Tube";

// named functions
import { addNumber } from "@polygonjs/polygonjs/dist/src/engine/functions/addNumber";
import { addVector } from "@polygonjs/polygonjs/dist/src/engine/functions/addVector";
import { elementsToArrayPrimitive } from "@polygonjs/polygonjs/dist/src/engine/functions/elementsToArrayPrimitive";
import { floatToVec3 } from "@polygonjs/polygonjs/dist/src/engine/functions/floatToVec3";
import { getIntersectionPropertyPoint } from "@polygonjs/polygonjs/dist/src/engine/functions/getIntersectionPropertyPoint";
import { getObject } from "@polygonjs/polygonjs/dist/src/engine/functions/getObject";
import { getObjectAttribute } from "@polygonjs/polygonjs/dist/src/engine/functions/getObjectAttribute";
import { getObjectAttributeAutoDefault } from "@polygonjs/polygonjs/dist/src/engine/functions/getObjectAttributeAutoDefault";
import { getObjectAttributeRef } from "@polygonjs/polygonjs/dist/src/engine/functions/getObjectAttributeRef";
import { getObjectChild } from "@polygonjs/polygonjs/dist/src/engine/functions/getObjectChild";
import { getObjectProperty } from "@polygonjs/polygonjs/dist/src/engine/functions/getObjectProperty";
import { getParent } from "@polygonjs/polygonjs/dist/src/engine/functions/getParent";
import { globalsRayFromCursor } from "@polygonjs/polygonjs/dist/src/engine/functions/globalsRayFromCursor";
import { globalsTime } from "@polygonjs/polygonjs/dist/src/engine/functions/globalsTime";
import { globalsTimeDelta } from "@polygonjs/polygonjs/dist/src/engine/functions/globalsTimeDelta";
import { lengthVector } from "@polygonjs/polygonjs/dist/src/engine/functions/lengthVector";
import { mathFloat_1 } from "@polygonjs/polygonjs/dist/src/engine/functions/mathFloat_1";
import { mathFloat_2 } from "@polygonjs/polygonjs/dist/src/engine/functions/mathFloat_2";
import { mathFloat_4 } from "@polygonjs/polygonjs/dist/src/engine/functions/mathFloat_4";
import { multAdd } from "@polygonjs/polygonjs/dist/src/engine/functions/multAdd";
import { multScalarVector3 } from "@polygonjs/polygonjs/dist/src/engine/functions/multScalarVector3";
import { rand } from "@polygonjs/polygonjs/dist/src/engine/functions/rand";
import { rayIntersectObject3D } from "@polygonjs/polygonjs/dist/src/engine/functions/rayIntersectObject3D";
import { raySet } from "@polygonjs/polygonjs/dist/src/engine/functions/raySet";
import { setGeometryPositions } from "@polygonjs/polygonjs/dist/src/engine/functions/setGeometryPositions";
import { setObjectAttribute } from "@polygonjs/polygonjs/dist/src/engine/functions/setObjectAttribute";
import { setObjectPosition } from "@polygonjs/polygonjs/dist/src/engine/functions/setObjectPosition";
import { subtractVector } from "@polygonjs/polygonjs/dist/src/engine/functions/subtractVector";

export const requiredImports_bvh_demo_multiple_rays = {
  nodes: [
    EnvMapCopNode,
    ImageCopNode,
    ImageEXRCopNode,
    CameraOrbitControlsEventNode,
    LineBasicBuilderMatNode,
    MeshStandardMatNode,
    MeshStandardBuilderMatNode,
    PointsBuilderMatNode,
    SkyMatNode,
    CopNetworkObjNode,
    GeoObjNode,
    BVHSopNode,
    BVHVisualizerSopNode,
    ActorSopNode,
    AddSopNode,
    AreaLightSopNode,
    AttribCreateSopNode,
    AttribDeleteSopNode,
    AttribIdSopNode,
    BoxSopNode,
    CameraControlsSopNode,
    CircleSopNode,
    CopySopNode,
    FileGLTFSopNode,
    HemisphereLightSopNode,
    HierarchySopNode,
    JitterSopNode,
    LineSopNode,
    MaterialSopNode,
    MaterialsNetworkSopNode,
    MergeSopNode,
    ObjectPropertiesSopNode,
    PerspectiveCameraSopNode,
    PolarTransformSopNode,
    SphereSopNode,
    SpotLightSopNode,
    TransformSopNode,
    TubeSopNode,
  ],
  operations: [],
  jsFunctions: [
    addNumber,
    addVector,
    elementsToArrayPrimitive,
    floatToVec3,
    getIntersectionPropertyPoint,
    getObject,
    getObjectAttribute,
    getObjectAttributeAutoDefault,
    getObjectAttributeRef,
    getObjectChild,
    getObjectProperty,
    getParent,
    globalsRayFromCursor,
    globalsTime,
    globalsTimeDelta,
    lengthVector,
    mathFloat_1,
    mathFloat_2,
    mathFloat_4,
    multAdd,
    multScalarVector3,
    rand,
    rayIntersectObject3D,
    raySet,
    setGeometryPositions,
    setObjectAttribute,
    setObjectPosition,
    subtractVector,
  ],
};

// cop
import { EnvMapCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/EnvMap";
import { ImageCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/Image";
import { ImageEXRCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/ImageEXR";
// event
import { CameraOrbitControlsEventNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/event/CameraOrbitControls";
// mat
import { MeshStandardMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshStandard";
import { MeshStandardBuilderMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshStandardBuilder";
import { SkyMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/Sky";
// obj
import { CopNetworkObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/CopNetwork";
import { GeoObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/Geo";
// sop
import { BVHSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/BVH";
import { AreaLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/AreaLight";
import { BboxScatterSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/BboxScatter";
import { BoxSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Box";
import { CameraControlsSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/CameraControls";
import { CopySopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Copy";
import { DeleteSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Delete";
import { FileOBJSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/FileOBJ";
import { HemisphereLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/HemisphereLight";
import { HierarchySopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Hierarchy";
import { JitterSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Jitter";
import { MaterialSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Material";
import { MaterialsNetworkSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/MaterialsNetwork";
import { MergeSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Merge";
import { ObjectPropertiesSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/ObjectProperties";
import { PerspectiveCameraSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PerspectiveCamera";
import { PhysicsDebugSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PhysicsDebug";
import { PhysicsRBDAttributesSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PhysicsRBDAttributes";
import { PhysicsWorldSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PhysicsWorld";
import { PlaneSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Plane";
import { PointBuilderSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PointBuilder";
import { PolarTransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PolarTransform";
import { SphereSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Sphere";
import { SpotLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/SpotLight";
import { TransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Transform";

// named functions
import { addVector } from "@polygonjs/polygonjs/dist/src/engine/functions/addVector";
import { floatToVec3 } from "@polygonjs/polygonjs/dist/src/engine/functions/floatToVec3";
import { globalsTime } from "@polygonjs/polygonjs/dist/src/engine/functions/globalsTime";
import { globalsTimeDelta } from "@polygonjs/polygonjs/dist/src/engine/functions/globalsTimeDelta";
import { lengthVector } from "@polygonjs/polygonjs/dist/src/engine/functions/lengthVector";
import { mathFloat_1 } from "@polygonjs/polygonjs/dist/src/engine/functions/mathFloat_1";
import { mathFloat_4 } from "@polygonjs/polygonjs/dist/src/engine/functions/mathFloat_4";
import { multAdd } from "@polygonjs/polygonjs/dist/src/engine/functions/multAdd";
import { physicsDebugUpdate } from "@polygonjs/polygonjs/dist/src/engine/functions/physicsDebugUpdate";
import { physicsWorldReset } from "@polygonjs/polygonjs/dist/src/engine/functions/physicsWorldReset";
import { physicsWorldStepSimulation } from "@polygonjs/polygonjs/dist/src/engine/functions/physicsWorldStepSimulation";

export const requiredImports_bvh_demo_heightfield = {
  nodes: [
    EnvMapCopNode,
    ImageCopNode,
    ImageEXRCopNode,
    CameraOrbitControlsEventNode,
    MeshStandardMatNode,
    MeshStandardBuilderMatNode,
    SkyMatNode,
    CopNetworkObjNode,
    GeoObjNode,
    BVHSopNode,
    AreaLightSopNode,
    BboxScatterSopNode,
    BoxSopNode,
    CameraControlsSopNode,
    CopySopNode,
    DeleteSopNode,
    FileOBJSopNode,
    HemisphereLightSopNode,
    HierarchySopNode,
    JitterSopNode,
    MaterialSopNode,
    MaterialsNetworkSopNode,
    MergeSopNode,
    ObjectPropertiesSopNode,
    PerspectiveCameraSopNode,
    PhysicsDebugSopNode,
    PhysicsRBDAttributesSopNode,
    PhysicsWorldSopNode,
    PlaneSopNode,
    PointBuilderSopNode,
    PolarTransformSopNode,
    SphereSopNode,
    SpotLightSopNode,
    TransformSopNode,
  ],
  operations: [],
  jsFunctions: [
    addVector,
    floatToVec3,
    globalsTime,
    globalsTimeDelta,
    lengthVector,
    mathFloat_1,
    mathFloat_4,
    multAdd,
    physicsDebugUpdate,
    physicsWorldReset,
    physicsWorldStepSimulation,
  ],
};
